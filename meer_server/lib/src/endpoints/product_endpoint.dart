// import 'package:meer_server/src/generated/protocol.dart';
// import 'package:serverpod/serverpod.dart';

// // Endpoint لإدارة منتجات الأسر المنتجة في تطبيق مِيْر
// class ProductEndpoint extends Endpoint {
//   // 1. إضافة منتج جديد
//   Future<Product> addProduct(Session session, Product product) async {
//     // التحقق من صحة البيانات الأساسية
//     if (product.name.trim().isEmpty) {
//       throw FormatException('اسم المنتج لا يمكن أن يكون فارغاً');
//     }
//     if (product.price <= 0) {
//       throw FormatException('سعر المنتج يجب أن يكون أكبر من صفر');
//     }

//     // حفظ المنتج في قاعدة البيانات
//     var insertedProduct = await Product.db.insertRow(session, product);
//     return insertedProduct;
//   }

//   // 2. جلب جميع المنتجات المتاحة لجميع الأسر المنتجة (للمشتري)
//   Future<List<Product>> getAllAvailableProducts(Session session) async {
//     return await Product.db.find(
//       session,
//       where: (p) => p.isAvailable.equals(true),
//     );
//   }

//   // 3. جلب منتجات أسرة منتجة محددة (باستخدام sellerId)
//   Future<List<Product>> getProductsBySeller(
//     Session session,
//     int sellerId,
//   ) async {
//     return await Product.db.find(
//       session,
//       where: (p) => p.sellerId.equals(sellerId),
//     );
//   }

//   // 4. تحديث حالة توفر المنتج (تفعيل/إيقاف بواسطة البائع)
//   Future<bool> toggleProductAvailability(
//     Session session,
//     int productId,
//     bool isAvailable,
//   ) async {
//     var product = await Product.db.findById(session, productId);
//     if (product == null) {
//       return false;
//     }

//     product.isAvailable = isAvailable;
//     await Product.db.updateRow(session, product);
//     return true;
//   }
// }
