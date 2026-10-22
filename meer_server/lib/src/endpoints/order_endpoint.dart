import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

// Endpoint لإدارة الطلبات وتغيير حالتها في تطبيق مِيْر
class OrderEndpoint extends Endpoint {
  // 1. إنشاء طلب جديد مع إدراج جميع عناصره (OrderItems)
  Future<OrderInfo> createOrder(
    Session session,
    OrderInfo order,
    List<OrderItem> items,
  ) async {
    if (items.isEmpty) {
      throw FormatException('لا يمكن إنشاء طلب بدون منتجات');
    }

    // تعيين زمن الإنشاء والحالة المبدئية
    order.createdAt = DateTime.now();
    order.status = 'pending'; // معلق بانتظار موافقة الأسرة المنتجة

    // حفظ رئيس الطلب (OrderInfo)
    var createdOrder = await OrderInfo.db.insertRow(session, order);

    // ربط العناصر برقم الطلب وحفظها
    for (var item in items) {
      item.orderId = createdOrder.id!;
      await OrderItem.db.insertRow(session, item);
    }

    return createdOrder;
  }

  // 2. جلب الطلبات الخاصة بالمشتري (Customer)
  Future<List<OrderInfo>> getCustomerOrders(
    Session session,
    int customerId,
  ) async {
    return await OrderInfo.db.find(
      session,
      where: (o) => o.customerId.equals(customerId),
      orderBy: (o) => o.createdAt.desc(),
    );
  }

  // 3. جلب الطلبات الخاصة بالأسرة المنتجة (Seller)
  Future<List<OrderInfo>> getSellerOrders(Session session, int sellerId) async {
    return await OrderInfo.db.find(
      session,
      where: (o) => o.sellerId.equals(sellerId),
      orderBy: (o) => o.createdAt.desc(),
    );
  }

  // 4. جلب الطلبات المتاحة للمناديب (الطلبات الجاهزة للتوصيل)
  Future<List<OrderInfo>> getAvailableOrdersForDrivers(Session session) async {
    return await OrderInfo.db.find(
      session,
      where: (o) => o.status.equals('ready') & o.driverId.equals(null),
      orderBy: (o) => o.createdAt.desc(),
    );
  }

  // 5. قبول المندوب للطلب
  Future<bool> acceptOrderAsDriver(
    Session session,
    int orderId,
    int driverId,
  ) async {
    var order = await OrderInfo.db.findById(session, orderId);
    if (order == null || order.driverId != null) {
      return false; // الطلب غير موجود أو تم قبوله من مندوب آخر
    }

    order.driverId = driverId;
    order.status = 'delivering'; // جاري التوصيل
    await OrderInfo.db.updateRow(session, order);
    return true;
  }

  // 6. تحديث حالة الطلب العامة (pending -> preparing -> ready -> delivering -> completed -> cancelled)
  Future<bool> updateOrderStatus(
    Session session,
    int orderId,
    String newStatus,
  ) async {
    var order = await OrderInfo.db.findById(session, orderId);
    if (order == null) {
      return false;
    }

    order.status = newStatus;
    await OrderInfo.db.updateRow(session, order);
    return true;
  }

  // استرجاع تفاصيل طلب محدد بالكامل مع المشتري والمنتجات
  Future<OrderInfo?> getOrderWithDetails(Session session, int orderId) async {
    // ربط طبقة البيانات بالمتحكم
    return await OrderInfo.db.findById(
      session,
      orderId,
      // تحديد العلاقات المُراد تضمينها في النتيجة
      include: OrderInfo.include(
        customer: User.include(), // جلب بيانات المشتري
        seller: User.include(), // جلب بيانات الأسرة المنتجة
        items: OrderItem.includeList(
          // جلب قائمة عناصر الطلب
          include: OrderItem.include(
            product: Product.include(), // جلب تفاصيل المنتج لكل عنصر
          ),
        ),
      ),
    );
  }
}
