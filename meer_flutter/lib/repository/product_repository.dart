import 'package:fpdart/fpdart.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/client.dart';
import 'package:meer_flutter/core/class/failure.dart';

class ProductRepository {
  ProductRepository();

  // 1.
  /// إضافة منتج جديد للأسرة المنتجة الحالية.
  Future<Either<Failure, Product>> addProduct(
    Product product,
  ) async {
    try {
      final insertedProduct = await client.product.addProduct(
        product,
      );

      return Right(insertedProduct);
    } catch (e) {
      return Left(
        ServerFailure('تعذر إضافة المنتج: ${e.toString()}'),
      );
    }
  }

  // 2.
  /// تعديل بيانات منتج مملوك للبائع الحالي.
  Future<Either<Failure, Product>> updateProduct(
    Product product,
  ) async {
    if (product.id == null) {
      return Left(
        ServerFailure('معرّف المنتج غير صالح.'),
      );
    }

    try {
      final updatedProduct = await client.product.updateProduct(
        product,
      );

      return Right(updatedProduct);
    } catch (e) {
      return Left(
        ServerFailure('تعذر تعديل المنتج: ${e.toString()}'),
      );
    }
  }

  // 3.
  /// حذف منتج مملوك للبائع الحالي.
  Future<Either<Failure, bool>> deleteProduct(
    int productId,
  ) async {
    try {
      final success = await client.product.deleteProduct(
        productId,
      );

      if (!success) {
        return Left(
          ServerFailure('المنتج غير موجود أو سبق حذفه.'),
        );
      }

      return Right(success);
    } catch (e) {
      return Left(
        ServerFailure('تعذر حذف المنتج: ${e.toString()}'),
      );
    }
  }

  // 4.
  /// جلب جميع المنتجات المتاحة للمشترين.
  Future<Either<Failure, List<Product>>> getAllAvailableProducts() async {
    try {
      final products = await client.product.getAllAvailableProducts();

      return Right(products);
    } catch (e) {
      return Left(
        ServerFailure('تعذر تحميل المنتجات: ${e.toString()}'),
      );
    }
  }

  // 5.
  /// جلب المنتجات المتاحة لأسرة منتجة محددة.
  Future<Either<Failure, List<Product>>> getProductsBySeller(
    int sellerId,
  ) async {
    try {
      final products = await client.product.getProductsBySeller(
        sellerId,
      );

      return Right(products);
    } catch (e) {
      return Left(
        ServerFailure(
          'تعذر تحميل منتجات الأسرة المنتجة: ${e.toString()}',
        ),
      );
    }
  }

  // 6.
  /// جلب جميع منتجات البائع الحالي،
  /// بما فيها المنتجات غير المتاحة.
  Future<Either<Failure, List<Product>>> getMyProducts() async {
    try {
      final products = await client.product.getMyProducts();

      return Right(products);
    } catch (e) {
      return Left(
        ServerFailure(
          'تعذر تحميل منتجات متجرك: ${e.toString()}',
        ),
      );
    }
  }

  // 7.
  /// تفعيل منتج أو إيقاف عرضه.
  Future<Either<Failure, bool>> toggleProductAvailability({
    required int productId,
    required bool isAvailable,
  }) async {
    try {
      final success = await client.product.toggleProductAvailability(
        productId,
        isAvailable,
      );

      if (!success) {
        return Left(
          ServerFailure('المنتج غير موجود.'),
        );
      }

      return Right(success);
    } catch (e) {
      return Left(
        ServerFailure(
          'تعذر تحديث حالة توفر المنتج: ${e.toString()}',
        ),
      );
    }
  }
}
