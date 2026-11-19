import 'package:fpdart/fpdart.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/client.dart';
import 'package:meer_flutter/core/class/failure.dart';

class FavoritesRepository {
  // 1.
  /// جلب مفضلة المستخدم الحالي.
  Future<Either<Failure, List<ProductPresentation>>> getMyFavorites() async {
    try {
      final products = await client.favorite.getMyFavorites();
      return Right(products);
    } catch (e) {
      return Left(
        ServerFailure('تعذر تحميل المفضلة: ${e.toString()}'),
      );
    }
  }

  // 2.
  /// إضافة منتج إلى المفضلة.
  Future<Either<Failure, List<ProductPresentation>>> addFavorite(
    Product product,
  ) async {
    if (product.id == null) {
      return Left(
        ServerFailure('معرّف المنتج غير صالح.'),
      );
    }

    try {
      final success = await client.favorite.addFavorite(
        product.id!,
      );

      if (!success) {
        return Left(
          ServerFailure('تعذرت إضافة المنتج إلى المفضلة.'),
        );
      }

      final products = await client.favorite.getMyFavorites();
      return Right(products);
    } catch (e) {
      return Left(
        ServerFailure('تعذرت إضافة المنتج: ${e.toString()}'),
      );
    }
  }

  // 3.
  /// إزالة منتج من المفضلة.
  Future<Either<Failure, List<ProductPresentation>>> removeFavorite(
    int productId,
  ) async {
    try {
      final success = await client.favorite.removeFavorite(
        productId,
      );

      if (!success) {
        return Left(
          ServerFailure('المنتج غير موجود في المفضلة.'),
        );
      }

      final products = await client.favorite.getMyFavorites();
      return Right(products);
    } catch (e) {
      return Left(
        ServerFailure('تعذرت إزالة المنتج: ${e.toString()}'),
      );
    }
  }

  // 4.
  /// إفراغ المفضلة.
  Future<Either<Failure, List<ProductPresentation>>> clearFavorites() async {
    try {
      await client.favorite.clearMyFavorites();

      final products = await client.favorite.getMyFavorites();
      return Right(products);
    } catch (e) {
      return Left(
        ServerFailure('تعذر إفراغ المفضلة: ${e.toString()}'),
      );
    }
  }
}
