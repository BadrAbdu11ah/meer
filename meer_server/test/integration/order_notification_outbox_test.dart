import 'package:meer_server/src/generated/protocol.dart';
import 'package:meer_server/src/services/order_notification_service.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const _customerName = 'عميل الاختبار';
const _sellerName = 'أسرة الاختبار';

void main() {
  withServerpod('Given a customer and a family with registered devices', (
    sessionBuilder,
    endpoints,
  ) {
    late TestSessionBuilder customerSession;
    late TestSessionBuilder sellerSession;
    late MeerUserProfile customer;
    late MeerUserProfile seller;
    late Product product;

    /// ينشئ مستخدم مصادقة وملفًا للتطبيق، ويرجع الملف وجلسته.
    Future<(MeerUserProfile, TestSessionBuilder)> createUser({
      required String phone,
      required String fullName,
      bool isSeller = false,
    }) async {
      final session = sessionBuilder.build();

      final authUser = await const AuthUsers().create(session);

      final profile = await MeerUserProfile.db.insertRow(
        session,
        MeerUserProfile(
          authUserId: authUser.id,
          fullName: fullName,
          phone: phone,
          role: isSeller ? 'seller' : 'customer',
          isSeller: isSeller,
          storeName: isSeller ? fullName : null,
          storeAddress: isSeller ? 'حي الاختبار، المدينة المنورة' : null,
          storeCity: isSeller ? MeerCity.madinah : null,
          offersDelivery: isSeller,
          createdAt: DateTime.now().toUtc(),
        ),
      );

      final authenticated = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          authUser.id.toString(),
          {},
        ),
      );

      return (profile, authenticated);
    }

    Future<void> registerDevice(
      MeerUserProfile profile,
      String installationId,
    ) async {
      await UserDeviceInstallation.db.insertRow(
        sessionBuilder.build(),
        UserDeviceInstallation(
          authUserId: profile.authUserId!,
          installationId: installationId,
          platform: 'android',
        ),
      );
    }

    Future<OrderInfo> createOrder({String method = 'pickup'}) {
      return endpoints.order.createOrder(
        customerSession,
        [OrderItemRequest(productId: product.id!, quantity: 1)],
        method == 'delivery' ? 'حي الاختبار، شارع 1' : null,
        null,
        null,
        method,
      );
    }

    Future<List<NotificationOutbox>> outboxFor(String event) {
      return NotificationOutbox.db.find(
        sessionBuilder.build(),
        where: (t) => t.event.equals(event),
        orderBy: (t) => t.installationId,
      );
    }

    Future<int> outboxCount() {
      return NotificationOutbox.db.count(sessionBuilder.build());
    }

    setUp(() async {
      final createdSeller = await createUser(
        phone: '966500000001',
        fullName: _sellerName,
        isSeller: true,
      );
      seller = createdSeller.$1;
      sellerSession = createdSeller.$2;

      final createdCustomer = await createUser(
        phone: '966500000002',
        fullName: _customerName,
      );
      customer = createdCustomer.$1;
      customerSession = createdCustomer.$2;

      product = await Product.db.insertRow(
        sessionBuilder.build(),
        Product(
          sellerId: seller.id!,
          name: 'كبسة',
          price: 40,
          isAvailable: true,
          createdAt: DateTime.now().toUtc(),
        ),
      );

      await registerDevice(seller, 'seller-phone');
      await registerDevice(seller, 'seller-tablet');
      await registerDevice(customer, 'customer-phone');
    });

    test(
      'when creating an order then one pending new_order record is stored per seller device',
      () async {
        final order = await createOrder();

        final records = await outboxFor('new_order');

        expect(await outboxCount(), 2);
        expect(
          records.map((r) => r.installationId),
          ['seller-phone', 'seller-tablet'],
        );

        final record = records.first;

        expect(record.recipientProfileId, seller.id);
        expect(record.orderId, order.id);
        expect(record.title, 'طلب جديد #${order.id}');
        expect(record.body, 'وصلك طلب جديد من العميل $_customerName.');
        expect(record.data, {
          'type': 'order',
          'event': 'new_order',
          'orderId': '${order.id}',
          'actorName': _customerName,
        });
        expect(record.status, 'pending');
        expect(record.attemptCount, 0);
        expect(record.lockedAt, isNull);
        expect(record.sentAt, isNull);
        expect(record.lastError, isNull);
        expect(record.dedupeKey, '${order.id}:new_order:seller-phone');
      },
    );

    test(
      'when the seller has no devices then the order is created without records',
      () async {
        await UserDeviceInstallation.db.deleteWhere(
          sessionBuilder.build(),
          where: (t) => t.authUserId.equals(seller.authUserId!),
        );

        final order = await createOrder();

        expect(order.id, isNotNull);
        expect(await outboxCount(), 0);
      },
    );

    test(
      'when an order is refused then no record is stored',
      () async {
        await expectLater(
          endpoints.order.createOrder(
            sellerSession,
            [OrderItemRequest(productId: product.id!, quantity: 1)],
            null,
            null,
            null,
            'pickup',
          ),
          throwsA(anything),
        );

        expect(await outboxCount(), 0);
      },
    );

    test(
      'when the customer cancels then an order_cancelled record is stored for the seller',
      () async {
        final order = await createOrder();

        expect(
          await endpoints.order.cancelMyOrder(customerSession, order.id!),
          isTrue,
        );

        final records = await outboxFor('order_cancelled');

        expect(records, hasLength(2));
        expect(records.first.recipientProfileId, seller.id);
        expect(records.first.title, 'إلغاء الطلب #${order.id}');
        expect(records.first.body, 'ألغى العميل $_customerName الطلب.');
        expect(records.first.data['event'], 'order_cancelled');
        expect(records.first.data['actorName'], _customerName);
      },
    );

    test(
      'when cancelling is refused then no order_cancelled record is stored',
      () async {
        final order = await createOrder();
        await endpoints.order.acceptMyOrder(sellerSession, order.id!);

        // لا يمكن للعميل إلغاء طلب بدأ تجهيزه.
        expect(
          await endpoints.order.cancelMyOrder(customerSession, order.id!),
          isFalse,
        );

        expect(await outboxFor('order_cancelled'), isEmpty);
      },
    );

    test(
      'when the family accepts then an order_accepted record is stored for the customer',
      () async {
        final order = await createOrder();

        await endpoints.order.acceptMyOrder(sellerSession, order.id!);

        final records = await outboxFor('order_accepted');

        expect(records, hasLength(1));
        expect(records.single.recipientProfileId, customer.id);
        expect(records.single.installationId, 'customer-phone');
        expect(records.single.title, 'تم قبول طلبك #${order.id}');
        expect(
          records.single.body,
          'قبلت الأسرة $_sellerName طلبك وبدأت تجهيزه.',
        );
        expect(records.single.data, {
          'type': 'order',
          'event': 'order_accepted',
          'orderId': '${order.id}',
          'actorName': _sellerName,
        });
      },
    );

    test(
      'when the family rejects then an order_rejected record is stored for the customer',
      () async {
        final order = await createOrder();

        await endpoints.order.rejectMyOrder(sellerSession, order.id!);

        final records = await outboxFor('order_rejected');

        expect(records, hasLength(1));
        expect(records.single.recipientProfileId, customer.id);
        expect(records.single.title, 'تعذر تنفيذ طلبك #${order.id}');
        expect(
          records.single.body,
          'لم تتمكن الأسرة $_sellerName من تنفيذ طلبك.',
        );
        expect(await outboxFor('order_accepted'), isEmpty);
      },
    );

    test(
      'when a pickup order is ready then the order_ready record mentions pickup',
      () async {
        final order = await createOrder();
        await endpoints.order.acceptMyOrder(sellerSession, order.id!);

        await endpoints.order.markMyOrderReady(sellerSession, order.id!);

        final records = await outboxFor('order_ready');

        expect(records, hasLength(1));
        expect(records.single.recipientProfileId, customer.id);
        expect(records.single.title, 'طلبك جاهز #${order.id}');
        expect(
          records.single.body,
          'طلبك جاهز للاستلام من الأسرة $_sellerName.',
        );
      },
    );

    test(
      'when a delivery order is ready then the order_ready record mentions delivery',
      () async {
        final order = await createOrder(method: 'delivery');
        await endpoints.order.acceptMyOrder(sellerSession, order.id!);

        await endpoints.order.markMyOrderReady(sellerSession, order.id!);

        final records = await outboxFor('order_ready');

        expect(
          records.single.body,
          'الأسرة $_sellerName جهزت طلبك للتوصيل.',
        );
      },
    );

    test(
      'when the order is completed then no further record is stored',
      () async {
        final order = await createOrder();
        await endpoints.order.acceptMyOrder(sellerSession, order.id!);
        await endpoints.order.markMyOrderReady(sellerSession, order.id!);
        final countBeforeCompletion = await outboxCount();

        expect(
          await endpoints.order.markMyOrderCompleted(sellerSession, order.id!),
          isTrue,
        );

        // new_order لجهازي البائع، ثم order_accepted و order_ready للعميل.
        expect(countBeforeCompletion, 4);
        expect(await outboxCount(), countBeforeCompletion);
      },
    );

    test(
      'when the same event is enqueued twice then no duplicate record is stored',
      () async {
        final order = await createOrder();
        final session = sessionBuilder.build();

        await session.db.transaction((transaction) async {
          await OrderNotificationService().enqueueNewOrderForSeller(
            session,
            order,
            transaction: transaction,
          );
        });

        expect(await outboxFor('new_order'), hasLength(2));
      },
    );

    test(
      'when a device is added later then only the new device gets a record',
      () async {
        final order = await createOrder();
        await registerDevice(seller, 'seller-watch');
        final session = sessionBuilder.build();

        await session.db.transaction((transaction) async {
          await OrderNotificationService().enqueueNewOrderForSeller(
            session,
            order,
            transaction: transaction,
          );
        });

        final records = await outboxFor('new_order');

        expect(
          records.map((r) => r.installationId),
          ['seller-phone', 'seller-tablet', 'seller-watch'],
        );
      },
    );

    test(
      'when the transaction is rolled back then its records are rolled back too',
      () async {
        final order = await createOrder();
        final session = sessionBuilder.build();

        await expectLater(
          session.db.transaction((transaction) async {
            await OrderNotificationService().enqueueOrderAcceptedForCustomer(
              session,
              order,
              transaction: transaction,
            );

            final enqueued = await NotificationOutbox.db.count(
              session,
              where: (t) => t.event.equals('order_accepted'),
              transaction: transaction,
            );
            expect(enqueued, 1);

            throw StateError('order update failed');
          }),
          throwsStateError,
        );

        expect(await outboxFor('order_accepted'), isEmpty);
      },
    );

    test(
      'when the dispatch future call runs with nothing due then it completes',
      () async {
        await endpoints.futureCalls.notificationOutbox.dispatch(
          sessionBuilder,
        );

        expect(await outboxCount(), 0);
      },
    );
  });
}
