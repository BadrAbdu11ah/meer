import 'package:meer_server/src/generated/protocol.dart';
import 'package:meer_server/src/services/order_notification_service.dart';
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

  /// تحويل الطلبات إلى بيانات العرض، مع إظهار اسم الطرف الآخر فقط.
  Future<List<OrderPresentation>> _toOrderPresentations(
    Session session,
    List<OrderInfo> orders, {
    required bool isSellerView,
  }) async {
    if (orders.isEmpty) {
      return [];
    }

    // تحديد الطرف الآخر الذي نحتاج إلى اسمه فقط.
    final profileIds = orders
        .map((order) => isSellerView ? order.customerId : order.sellerId)
        .toSet();

    // جلب الملفات المطلوبة دفعة واحدة لتجنب استعلام لكل طلب.
    final profiles = await MeerUserProfile.db.find(
      session,
      where: (profile) => profile.id.inSet(profileIds),
    );

    final profilesById = {
      for (final profile in profiles)
        if (profile.id != null) profile.id!: profile,
    };

    return orders.map((order) {
      final counterpartyId = isSellerView ? order.customerId : order.sellerId;

      final profile = profilesById[counterpartyId];

      String counterpartyName;

      if (isSellerView) {
        // البائع يرى اسم العميل.
        counterpartyName = profile?.fullName.trim() ?? '';

        if (counterpartyName.isEmpty) {
          counterpartyName = 'عميل';
        }
      } else {
        // العميل يرى اسم الأسرة.
        final storeName = profile?.storeName?.trim() ?? '';

        counterpartyName = storeName.isNotEmpty
            ? storeName
            : profile?.fullName.trim() ?? '';

        if (counterpartyName.isEmpty) {
          counterpartyName = 'أسرة منتجة';
        }
      }

      return OrderPresentation(
        order: order,
        counterpartyName: counterpartyName,
        isSellerView: isSellerView,
      );
    }).toList();
  }

  // --------------------------------------------------
  // إنشاء طلب جديد
  // --------------------------------------------------

  Future<OrderInfo> createOrder(
    Session session,
    List<OrderItemRequest> requestedItems,
    String? deliveryAddress,
    double? deliveryLatitude,
    double? deliveryLongitude,
    String fulfillmentMethod,
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

    // التحقق من طريقة تنفيذ الطلب.
    if (!const {'delivery', 'pickup'}.contains(fulfillmentMethod)) {
      throw FormatException('طريقة تنفيذ الطلب غير صحيحة.');
    }

    // تجهيز عنوان وإحداثيات التوصيل.
    String? normalizedAddress;
    double? normalizedLatitude;
    double? normalizedLongitude;

    if (fulfillmentMethod == 'delivery') {
      final address = deliveryAddress?.trim();

      if (address == null || address.isEmpty) {
        throw FormatException('عنوان التوصيل مطلوب.');
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

      normalizedAddress = address;
      normalizedLatitude = deliveryLatitude;
      normalizedLongitude = deliveryLongitude;
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
    final createdOrder = await session.db.transaction(
      (transaction) async {
        final validatedProducts = <Product>[];

        int? sellerId;
        double productsSubtotal = 0;

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

          productsSubtotal += lineTotal;

          if (!productsSubtotal.isFinite) {
            throw FormatException(
              'إجمالي المنتجات غير صالح.',
            );
          }

          validatedProducts.add(product);
        }

        if (sellerId == null) {
          throw Exception('تعذر تحديد الأسرة المنتجة.');
        }

        // جلب بيانات الأسرة والتحقق من قدرتها على تنفيذ الطلب.
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

        // لا يطلب البائع من متجره نفسه.
        // if (seller.id == customer.id) {
        //   throw FormatException('لا يمكنك طلب منتجات من متجرك.');
        // }

        // التحقق من توفر طريقة التنفيذ المطلوبة.
        if (fulfillmentMethod == 'delivery' && !seller.offersDelivery) {
          throw FormatException(
            'هذه الأسرة لا توفر خدمة التوصيل.',
          );
        }

        if (fulfillmentMethod == 'pickup') {
          final pickupAddress = seller.storeAddress?.trim();

          if (pickupAddress == null || pickupAddress.isEmpty) {
            throw Exception(
              'الأسرة لم تحدد عنوان الاستلام بعد.',
            );
          }
        }

        // الخادم وحده يحدد رسوم التوصيل.
        var deliveryFee = 0.0;

        if (fulfillmentMethod == 'delivery') {
          if (!seller.deliveryFee.isFinite || seller.deliveryFee < 0) {
            throw Exception(
              'رسوم التوصيل المحددة من الأسرة غير صالحة.',
            );
          }

          deliveryFee = seller.deliveryFee;
        }

        // تقريب المبالغ إلى منزلتين عشريتين.
        productsSubtotal = double.parse(
          productsSubtotal.toStringAsFixed(2),
        );

        deliveryFee = double.parse(
          deliveryFee.toStringAsFixed(2),
        );

        final totalAmount = double.parse(
          (productsSubtotal + deliveryFee).toStringAsFixed(2),
        );

        if (!totalAmount.isFinite) {
          throw FormatException('إجمالي الطلب غير صالح.');
        }

        // إنشاء الطلب بالقيم المحسوبة والمتحقق منها من الخادم.
        final order = OrderInfo(
          customerId: customer.id!,
          sellerId: sellerId,
          status: 'pending',
          fulfillmentMethod: fulfillmentMethod,
          productsSubtotal: productsSubtotal,
          deliveryFee: deliveryFee,
          totalAmount: totalAmount,
          deliveryAddress: normalizedAddress,
          deliveryLatitude: normalizedLatitude,
          deliveryLongitude: normalizedLongitude,
          pickupAddress: null,

          // العمولة تحسب على المنتجات فقط.
          commissionBaseAmount: productsSubtotal,
          commissionRate: null,
          commissionAmount: null,

          // الدفع اليدوي للتجربة الأولية.
          paymentMethod: 'manual',
          paymentStatus: 'unpaid',

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

        // سجل إشعار البائع يُحفظ مع الطلب في نفس الـ Transaction.
        await OrderNotificationService().enqueueNewOrderForSeller(
          session,
          createdOrder,
          transaction: transaction,
        );

        return createdOrder;
      },
      settings: TransactionSettings(
        isolationLevel: IsolationLevel.serializable,
      ),
    );

    return createdOrder;
  }

  // --------------------------------------------------
  // جلب طلبات المشتري الحالي
  // --------------------------------------------------

  Future<List<OrderPresentation>> getMyCustomerOrders(
    Session session,
  ) async {
    final customer = await _getCurrentProfile(session);

    final orders = await OrderInfo.db.find(
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

    return _toOrderPresentations(
      session,
      orders,
      isSellerView: false,
    );
  }

  // --------------------------------------------------
  // إلغاء طلب المشتري الحالي
  // --------------------------------------------------

  /// يسمح بالإلغاء فقط قبل قبول الأسرة وبدء التجهيز.
  Future<bool> cancelMyOrder(
    Session session,
    int orderId,
  ) async {
    final customer = await _getCurrentProfile(session);

    final cancelledOrder = await session.db.transaction(
      (transaction) async {
        final order = await OrderInfo.db.findById(
          session,
          orderId,
          lockMode: LockMode.forUpdate,
          transaction: transaction,
        );

        if (order == null) {
          return null;
        }

        // التأكد من أن الطلب يخص المستخدم الحالي.
        if (order.customerId != customer.id) {
          throw Exception('هذا الطلب لا يخص حسابك.');
        }

        // الإلغاء مسموح فقط قبل بدء التجهيز.
        if (order.status != 'pending') {
          return null;
        }

        order.status = 'cancelled';

        await OrderInfo.db.updateRow(
          session,
          order,
          transaction: transaction,
        );

        // سجل إشعار البائع يُحفظ مع الإلغاء في نفس الـ Transaction.
        await OrderNotificationService().enqueueOrderCancelledForSeller(
          session,
          order,
          transaction: transaction,
        );

        return order;
      },
      settings: TransactionSettings(
        isolationLevel: IsolationLevel.readCommitted,
      ),
    );

    return cancelledOrder != null;
  }

  // --------------------------------------------------
  // جلب الطلبات الواردة للأسرة الحالية
  // --------------------------------------------------

  Future<List<OrderPresentation>> getMySellerOrders(
    Session session,
  ) async {
    final seller = await _getCurrentProfile(session);

    if (!seller.isSeller) {
      throw Exception('يجب تفعيل صلاحية البيع أولاً.');
    }

    final orders = await OrderInfo.db.find(
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

    return _toOrderPresentations(
      session,
      orders,
      isSellerView: true,
    );
  }

  // --------------------------------------------------
  // جلب تفاصيل طلب واحد للطرف صاحب الصلاحية
  // --------------------------------------------------

  Future<OrderPresentation> getMyOrderDetails(
    Session session,
    int orderId,
    bool isSellerView,
  ) async {
    final currentProfile = await _getCurrentProfile(session);

    if (orderId <= 0) {
      throw FormatException('رقم الطلب غير صحيح.');
    }

    final order = await OrderInfo.db.findFirstRow(
      session,
      where: (o) => o.id.equals(orderId),
      include: OrderInfo.include(
        items: OrderItem.includeList(
          include: OrderItem.include(
            product: Product.include(),
          ),
        ),
      ),
    );

    if (order == null) {
      throw Exception('لم يتم العثور على الطلب.');
    }

    // التحقق من ملكية الطلب حسب منظور العرض المطلوب.
    if (isSellerView) {
      if (!currentProfile.isSeller || order.sellerId != currentProfile.id) {
        throw Exception('هذا الطلب لا يخص متجرك.');
      }
    } else {
      if (order.customerId != currentProfile.id) {
        throw Exception('هذا الطلب لا يخص حسابك.');
      }
    }

    final presentations = await _toOrderPresentations(
      session,
      [order],
      isSellerView: isSellerView,
    );

    return presentations.single;
  }

  // --------------------------------------------------
  // قبول الطلب
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
  // رفض الطلب
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
  // تأكيد جاهزية الطلب
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
  // تأكيد تسليم الطلب للمشتري
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
  // دالة داخلية لتغيير حالة طلب الأسرة الحالية
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

    final updatedOrder = await session.db.transaction(
      (transaction) async {
        // قفل الطلب حتى تنتهي العملية الحالية.
        final order = await OrderInfo.db.findById(
          session,
          orderId,
          lockMode: LockMode.forUpdate,
          transaction: transaction,
        );

        if (order == null) {
          return null;
        }

        // التأكد من ملكية الطلب.
        if (order.sellerId != seller.id) {
          throw Exception('هذا الطلب لا يخص متجرك.');
        }

        // التحقق من الحالة بعد الحصول على القفل.
        if (order.status != expectedStatus) {
          return null;
        }

        // عند قبول طلب الاستلام، ننسخ عنوان الأسرة إلى الطلب.
        if (newStatus == 'preparing' && order.fulfillmentMethod == 'pickup') {
          final currentSeller = await MeerUserProfile.db.findById(
            session,
            seller.id!,
            transaction: transaction,
          );

          final pickupAddress = currentSeller?.storeAddress?.trim();

          if (currentSeller == null ||
              !currentSeller.isSeller ||
              pickupAddress == null ||
              pickupAddress.isEmpty) {
            throw Exception(
              'تعذر قبول الطلب؛ لم يتم تحديد عنوان الاستلام.',
            );
          }

          order.pickupAddress = pickupAddress;
        }

        order.status = newStatus;

        await OrderInfo.db.updateRow(
          session,
          order,
          transaction: transaction,
        );

        // سجل إشعار العميل يُحفظ مع تغيير الحالة في نفس الـ Transaction.
        await _enqueueStatusNotification(
          session,
          order,
          newStatus: newStatus,
          transaction: transaction,
        );

        return order;
      },
      settings: TransactionSettings(
        isolationLevel: IsolationLevel.readCommitted,
      ),
    );

    return updatedOrder != null;
  }

  /// الحالة `completed` لا يصاحبها إشعار.
  Future<void> _enqueueStatusNotification(
    Session session,
    OrderInfo order, {
    required String newStatus,
    required Transaction transaction,
  }) async {
    final notificationService = OrderNotificationService();

    if (newStatus == 'preparing') {
      await notificationService.enqueueOrderAcceptedForCustomer(
        session,
        order,
        transaction: transaction,
      );
    } else if (newStatus == 'cancelled') {
      await notificationService.enqueueOrderRejectedForCustomer(
        session,
        order,
        transaction: transaction,
      );
    } else if (newStatus == 'ready') {
      await notificationService.enqueueOrderReadyForCustomer(
        session,
        order,
        transaction: transaction,
      );
    }
  }
}
