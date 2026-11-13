import 'package:meer_server/src/generated/protocol.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const _pickupAddress = 'حي الاختبار، المدينة المنورة';

void main() {
  withServerpod('Given orders between a customer and a family', (
    sessionBuilder,
    endpoints,
  ) {
    late TestSessionBuilder customerSession;
    late TestSessionBuilder sellerSession;
    late MeerUserProfile seller;
    late Product product;

    /// ينشئ مستخدم مصادقة وملفًا للتطبيق، ويرجع الملف وجلسته.
    Future<(MeerUserProfile, TestSessionBuilder)> createUser({
      required String phone,
      bool isSeller = false,
      bool offersDelivery = false,
      double deliveryFee = 0,
    }) async {
      final session = sessionBuilder.build();

      final authUser = await const AuthUsers().create(session);

      final profile = await MeerUserProfile.db.insertRow(
        session,
        MeerUserProfile(
          authUserId: authUser.id,
          fullName: 'مستخدم تجريبي',
          phone: phone,
          role: isSeller ? 'seller' : 'customer',
          isSeller: isSeller,
          storeName: isSeller ? 'أسرة الاختبار' : null,
          storeAddress: isSeller ? _pickupAddress : null,
          storeCity: isSeller ? MeerCity.madinah : null,
          offersDelivery: offersDelivery,
          deliveryFee: deliveryFee,
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

    Future<void> createSellerWithProduct({
      required bool offersDelivery,
      double deliveryFee = 0,
    }) async {
      final created = await createUser(
        phone: '966500000001',
        isSeller: true,
        offersDelivery: offersDelivery,
        deliveryFee: deliveryFee,
      );

      seller = created.$1;
      sellerSession = created.$2;

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
    }

    Future<OrderInfo> createOrder({
      required String method,
      TestSessionBuilder? buyerSession,
      int quantity = 2,
    }) {
      return endpoints.order.createOrder(
        buyerSession ?? customerSession,
        [OrderItemRequest(productId: product.id!, quantity: quantity)],
        method == 'delivery' ? 'حي الاختبار، شارع 1' : null,
        null,
        null,
        method,
      );
    }

    group('and a family that offers delivery with a fee', () {
      setUp(() async {
        await createSellerWithProduct(offersDelivery: true, deliveryFee: 10);

        final customer = await createUser(phone: '966500000002');
        customerSession = customer.$2;
      });

      test(
        'when creating a delivery order then the server adds the fee to the total',
        () async {
          final order = await createOrder(method: 'delivery');

          expect(order.fulfillmentMethod, 'delivery');
          expect(order.productsSubtotal, 80);
          expect(order.deliveryFee, 10);
          expect(order.totalAmount, 90);
          expect(order.deliveryAddress, isNotNull);
        },
      );

      test(
        'when creating a delivery order then the commission base excludes the fee',
        () async {
          final order = await createOrder(method: 'delivery');

          expect(order.commissionBaseAmount, 80);
        },
      );

      test(
        'when creating a pickup order then there is no fee and no pickup address yet',
        () async {
          final order = await createOrder(method: 'pickup');

          expect(order.fulfillmentMethod, 'pickup');
          expect(order.deliveryFee, 0);
          expect(order.totalAmount, order.productsSubtotal);
          expect(order.deliveryAddress, isNull);
          expect(order.pickupAddress, isNull);
        },
      );

      test(
        'when the family accepts a pickup order then its address is copied to the order',
        () async {
          final order = await createOrder(method: 'pickup');

          final accepted = await endpoints.order.acceptMyOrder(
            sellerSession,
            order.id!,
          );

          expect(accepted, isTrue);

          final updated = await OrderInfo.db.findById(
            sessionBuilder.build(),
            order.id!,
          );

          expect(updated!.status, 'preparing');
          expect(updated.pickupAddress, _pickupAddress);
        },
      );

      test(
        'when the family rejects a pickup order then its address is never exposed',
        () async {
          final order = await createOrder(method: 'pickup');

          await endpoints.order.rejectMyOrder(sellerSession, order.id!);

          final updated = await OrderInfo.db.findById(
            sessionBuilder.build(),
            order.id!,
          );

          expect(updated!.status, 'cancelled');
          expect(updated.pickupAddress, isNull);
        },
      );

      test(
        'when a delivery order has no address then it is rejected',
        () async {
          await expectLater(
            endpoints.order.createOrder(
              customerSession,
              [OrderItemRequest(productId: product.id!, quantity: 1)],
              null,
              null,
              null,
              'delivery',
            ),
            throwsA(isA<Exception>()),
          );
        },
      );

      test(
        'when the family orders from its own store then it is rejected',
        () async {
          await expectLater(
            createOrder(method: 'pickup', buyerSession: sellerSession),
            throwsA(isA<Exception>()),
          );
        },
      );

      test(
        'when the fulfillment method is unknown then it is rejected',
        () async {
          await expectLater(
            createOrder(method: 'drone'),
            throwsA(isA<Exception>()),
          );
        },
      );
    });

    group('and a family that does not offer delivery', () {
      setUp(() async {
        await createSellerWithProduct(offersDelivery: false);

        final customer = await createUser(phone: '966500000002');
        customerSession = customer.$2;
      });

      test(
        'when creating a delivery order then it is rejected',
        () async {
          await expectLater(
            createOrder(method: 'delivery'),
            throwsA(isA<Exception>()),
          );
        },
      );

      test(
        'when creating a pickup order then it succeeds',
        () async {
          final order = await createOrder(method: 'pickup');

          expect(order.status, 'pending');
        },
      );
    });

    group('and a family setting its delivery fee', () {
      setUp(() async {
        await createSellerWithProduct(offersDelivery: true, deliveryFee: 10);
      });

      test(
        'when the fee is above the maximum then it is rejected',
        () async {
          await expectLater(
            endpoints.seller.activateSeller(
              sellerSession,
              'أسرة الاختبار',
              null,
              _pickupAddress,
              MeerCity.madinah,
              null,
              24.5,
              39.6,
              true,
              501,
            ),
            throwsA(isA<Exception>()),
          );
        },
      );

      test(
        'when the fee is negative then it is rejected',
        () async {
          await expectLater(
            endpoints.seller.activateSeller(
              sellerSession,
              'أسرة الاختبار',
              null,
              _pickupAddress,
              MeerCity.madinah,
              null,
              24.5,
              39.6,
              true,
              -1,
            ),
            throwsA(isA<Exception>()),
          );
        },
      );

      test(
        'when the fee is valid then it is saved',
        () async {
          final profile = await endpoints.seller.activateSeller(
            sellerSession,
            'أسرة الاختبار',
            null,
            _pickupAddress,
            MeerCity.madinah,
            null,
            24.5,
            39.6,
            true,
            15,
          );

          expect(profile.deliveryFee, 15);
          expect(profile.offersDelivery, isTrue);
        },
      );
    });
  });
}
