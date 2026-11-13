import 'package:meer_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

class OrderEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  bool _isValidSaudiPhone(String phone) {
    return RegExp(r'^9665\d{8}$').hasMatch(phone);
  }

  /// استخراج ملف المستخدم الحالي من جلسة المصادقة.
  Future<MeerUserProfile> _getCurrentProfile(
    Session session,
  ) async {
    final authUserId = session.authenticated?.authUserId;

    if (authUserId == null) {
      throw Exception('يجب تسجيل الدخول أولاً.');
    }

    final profile = await MeerUserProfile.db.findFirstRow(
      session,
      where: (p) => p.authUserId.equals(authUserId),
    );

    if (profile == null || profile.id == null) {
      throw Exception(
        'لم يتم العثور على ملف المستخدم.',
      );
    }

    return profile;
  }

  // --------------------------------------------------
  // 1. إنشاء طلب جديد
  // --------------------------------------------------

  Future<OrderInfo> createOrder(
    Session session,
    List<OrderItemRequest> requestedItems,
    String deliveryAddress,
    double? deliveryLatitude,
    double? deliveryLongitude,
  ) async {
    final customer = await _getCurrentProfile(session);

    if (!_isValidSaudiPhone(customer.phone.trim())) {
      throw FormatException(
        'يجب توثيق رقم جوالك قبل إتمام الطلب.',
      );
    }

    if (requestedItems.isEmpty) {
      throw FormatException(
        'لا يمكن إنشاء طلب بدون منتجات.',
      );
    }

    final normalizedAddress = deliveryAddress.trim();

    if (normalizedAddress.isEmpty) {
      throw FormatException(
        'عنوان التوصيل مطلوب.',
      );
    }

    // يجب إرسال الإحداثيين معًا أو تركهما فارغين.
    if ((deliveryLatitude == null) != (deliveryLongitude == null)) {
      throw FormatException(
        'يجب تحديد إحداثيات الموقع كاملة.',
      );
    }

    if (deliveryLatitude != null &&
        (!deliveryLatitude.isFinite ||
            deliveryLatitude < -90 ||
            deliveryLatitude > 90)) {
      throw FormatException('خط العرض غير صحيح.');
    }

    if (deliveryLongitude != null &&
        (!deliveryLongitude.isFinite ||
            deliveryLongitude < -180 ||
            deliveryLongitude > 180)) {
      throw FormatException('خط الطول غير صحيح.');
    }

    // تجميع الكميات المكررة للمنتج نفسه.
    final quantities = <int, int>{};

    for (final item in requestedItems) {
      if (item.productId <= 0) {
        throw FormatException(
          'معرّف أحد المنتجات غير صحيح.',
        );
      }

      if (item.quantity <= 0) {
        throw FormatException(
          'يجب أن تكون كمية المنتج أكبر من صفر.',
        );
      }

      final newQuantity = (quantities[item.productId] ?? 0) + item.quantity;

      if (newQuantity > 2147483647) {
        throw FormatException('كمية المنتج غير صحيحة.');
      }

      quantities[item.productId] = newQuantity;
    }

    // حفظ الطلب وعناصره كوحدة واحدة.
    return await session.db.transaction(
      (transaction) async {
        final validatedProducts = <Product>[];

        int? sellerId;
        double totalAmount = 0;

        // جلب المنتجات والتحقق منها من قاعدة البيانات.
        for (final productId in quantities.keys) {
          final product = await Product.db.findById(
            session,
            productId,
            transaction: transaction,
          );

          if (product == null) {
            throw Exception(
              'أحد المنتجات لم يعد موجودًا.',
            );
          }

          if (!product.isAvailable) {
            throw Exception(
              'المنتج "${product.name}" غير متاح للبيع حاليًا.',
            );
          }

          if (!product.price.isFinite || product.price <= 0) {
            throw Exception(
              'سعر المنتج "${product.name}" غير صالح.',
            );
          }

          // الطلب الواحد يجب أن يكون من أسرة واحدة.
          sellerId ??= product.sellerId;

          if (sellerId != product.sellerId) {
            throw FormatException(
              'يجب أن تحتوي السلة على منتجات أسرة واحدة.',
            );
          }

          final quantity = quantities[productId]!;
          final lineTotal = product.price * quantity;

          if (!lineTotal.isFinite) {
            throw FormatException(
              'قيمة أحد عناصر الطلب غير صالحة.',
            );
          }

          totalAmount += lineTotal;

          if (!totalAmount.isFinite) {
            throw FormatException(
              'إجمالي الطلب غير صالح.',
            );
          }

          validatedProducts.add(product);
        }

        if (sellerId == null) {
          throw Exception('تعذر تحديد الأسرة المنتجة.');
        }

        // التحقق من أن صاحب المنتجات لا يزال بائعًا.
        final seller = await MeerUserProfile.db.findById(
          session,
          sellerId,
          transaction: transaction,
        );

        if (seller == null || !seller.isSeller) {
          throw Exception(
            'الأسرة المنتجة غير متاحة لاستقبال الطلبات.',
          );
        }

        // الخادم يحدد جميع البيانات الحساسة.
        final order = OrderInfo(
          customerId: customer.id!,
          sellerId: sellerId,
          status: 'pending',
          totalAmount: totalAmount,
          deliveryAddress: normalizedAddress,
          deliveryLatitude: deliveryLatitude,
          deliveryLongitude: deliveryLongitude,
          createdAt: DateTime.now().toUtc(),
        );

        final createdOrder = await OrderInfo.db.insertRow(
          session,
          order,
          transaction: transaction,
        );

        // حفظ تفاصيل المنتجات مع تثبيت السعر وقت الطلب.
        for (final product in validatedProducts) {
          await OrderItem.db.insertRow(
            session,
            OrderItem(
              orderId: createdOrder.id!,
              productId: product.id!,
              quantity: quantities[product.id]!,
              price: product.price,
            ),
            transaction: transaction,
          );
        }

        return createdOrder;
      },
      settings: TransactionSettings(
        isolationLevel: IsolationLevel.serializable,
      ),
    );
  }

  // --------------------------------------------------
  // 2. جلب طلبات المشتري الحالي
  // --------------------------------------------------

  Future<List<OrderInfo>> getMyCustomerOrders(
    Session session,
  ) async {
    final customer = await _getCurrentProfile(session);

    return await OrderInfo.db.find(
      session,
      where: (o) => o.customerId.equals(customer.id!),
      orderBy: (o) => o.createdAt.desc(),
      include: OrderInfo.include(
        items: OrderItem.includeList(
          include: OrderItem.include(
            product: Product.include(),
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------
  // 3. إلغاء طلب المشتري الحالي
  // --------------------------------------------------

  /// يسمح بالإلغاء فقط قبل قبول الأسرة وبدء التجهيز.
  Future<bool> cancelMyOrder(
    Session session,
    int orderId,
  ) async {
    final customer = await _getCurrentProfile(session);

    return await session.db.transaction(
      (transaction) async {
        final order = await OrderInfo.db.findById(
          session,
          orderId,
          lockMode: LockMode.forUpdate,
          transaction: transaction,
        );

        if (order == null) {
          return false;
        }

        // التأكد من أن الطلب يخص المستخدم الحالي.
        if (order.customerId != customer.id) {
          throw Exception('هذا الطلب لا يخص حسابك.');
        }

        // الإلغاء مسموح فقط قبل بدء التجهيز.
        if (order.status != 'pending') {
          return false;
        }

        order.status = 'cancelled';

        await OrderInfo.db.updateRow(
          session,
          order,
          transaction: transaction,
        );

        return true;
      },
      settings: TransactionSettings(
        isolationLevel: IsolationLevel.readCommitted,
      ),
    );
  }

  // --------------------------------------------------
  // 4. جلب الطلبات الواردة للأسرة الحالية
  // --------------------------------------------------

  Future<List<OrderInfo>> getMySellerOrders(
    Session session,
  ) async {
    final seller = await _getCurrentProfile(session);

    if (!seller.isSeller) {
      throw Exception('يجب تفعيل صلاحية البيع أولاً.');
    }

    return await OrderInfo.db.find(
      session,
      where: (o) => o.sellerId.equals(seller.id!),
      orderBy: (o) => o.createdAt.desc(),
      include: OrderInfo.include(
        items: OrderItem.includeList(
          include: OrderItem.include(
            product: Product.include(),
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------
  // 5. قبول الطلب
  // pending -> preparing
  // --------------------------------------------------

  Future<bool> acceptMyOrder(
    Session session,
    int orderId,
  ) async {
    return _changeMyOrderStatus(
      session,
      orderId,
      expectedStatus: 'pending',
      newStatus: 'preparing',
    );
  }

  // --------------------------------------------------
  // 6. رفض الطلب
  // pending -> cancelled
  // --------------------------------------------------

  Future<bool> rejectMyOrder(
    Session session,
    int orderId,
  ) async {
    return _changeMyOrderStatus(
      session,
      orderId,
      expectedStatus: 'pending',
      newStatus: 'cancelled',
    );
  }

  // --------------------------------------------------
  // 7. تأكيد جاهزية الطلب
  // preparing -> ready
  // --------------------------------------------------

  Future<bool> markMyOrderReady(
    Session session,
    int orderId,
  ) async {
    return _changeMyOrderStatus(
      session,
      orderId,
      expectedStatus: 'preparing',
      newStatus: 'ready',
    );
  }

  // --------------------------------------------------
  // 8. تأكيد تسليم الطلب للمشتري
  // ready -> completed
  // --------------------------------------------------

  Future<bool> markMyOrderCompleted(
    Session session,
    int orderId,
  ) async {
    return _changeMyOrderStatus(
      session,
      orderId,
      expectedStatus: 'ready',
      newStatus: 'completed',
    );
  }

  // --------------------------------------------------
  // 9. دالة داخلية لتغيير حالة طلب الأسرة الحالية
  // --------------------------------------------------

  Future<bool> _changeMyOrderStatus(
    Session session,
    int orderId, {
    required String expectedStatus,
    required String newStatus,
  }) async {
    final seller = await _getCurrentProfile(session);

    if (!seller.isSeller) {
      throw Exception('يجب تفعيل صلاحية البيع أولاً.');
    }

    return await session.db.transaction(
      (transaction) async {
        // قفل الطلب حتى تنتهي العملية الحالية.
        final order = await OrderInfo.db.findById(
          session,
          orderId,
          lockMode: LockMode.forUpdate,
          transaction: transaction,
        );

        if (order == null) {
          return false;
        }

        // التأكد من ملكية الطلب.
        if (order.sellerId != seller.id) {
          throw Exception('هذا الطلب لا يخص متجرك.');
        }

        // التحقق من الحالة بعد الحصول على القفل.
        if (order.status != expectedStatus) {
          return false;
        }

        order.status = newStatus;

        await OrderInfo.db.updateRow(
          session,
          order,
          transaction: transaction,
        );

        return true;
      },
      settings: TransactionSettings(
        isolationLevel: IsolationLevel.readCommitted,
      ),
    );
  }
}
