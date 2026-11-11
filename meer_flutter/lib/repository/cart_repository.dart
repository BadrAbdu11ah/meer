import 'package:fpdart/fpdart.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/client.dart';
import 'package:meer_flutter/core/class/failure.dart';
import 'package:meer_flutter/presentation/cart/models/cart_item.dart';

class CartRepository {
  /// جلب السلة الخاصة بالمستخدم الحالي من Serverpod.
  Future<Either<Failure, List<CartItem>>> getMyCart() async {
    try {
      final items = await _fetchCartItems();
      return Right(items);
    } catch (e) {
      return Left(
        ServerFailure('تعذر تحميل السلة: ${e.toString()}'),
      );
    }
  }

  /// إضافة منتج أو زيادة كميته بمقدار واحد.
  Future<Either<Failure, List<CartItem>>> addItem(
    Product product,
  ) async {
    if (product.id == null) {
      return Left(ServerFailure('معرّف المنتج غير صالح.'));
    }

    try {
      await client.cart.addItem(product.id!, 1);

      final items = await _fetchCartItems();
      return Right(items);
    } catch (e) {
      return Left(
        ServerFailure('تعذر إضافة المنتج إلى السلة: ${e.toString()}'),
      );
    }
  }

  /// تحديث كمية منتج محدد.
  Future<Either<Failure, List<CartItem>>> updateQuantity({
    required int productId,
    required int quantity,
  }) async {
    if (quantity <= 0) {
      return Left(ServerFailure('الكمية يجب أن تكون أكبر من صفر.'));
    }

    try {
      final success = await client.cart.updateQuantity(
        productId,
        quantity,
      );

      if (!success) {
        return Left(ServerFailure('تعذر العثور على المنتج في السلة.'));
      }

      final items = await _fetchCartItems();
      return Right(items);
    } catch (e) {
      return Left(
        ServerFailure('تعذر تحديث كمية المنتج: ${e.toString()}'),
      );
    }
  }

  /// حذف منتج من السلة.
  Future<Either<Failure, List<CartItem>>> removeItem(
    int productId,
  ) async {
    try {
      final success = await client.cart.removeItem(productId);

      if (!success) {
        return Left(ServerFailure('المنتج غير موجود في السلة.'));
      }

      final items = await _fetchCartItems();
      return Right(items);
    } catch (e) {
      return Left(
        ServerFailure('تعذر حذف المنتج من السلة: ${e.toString()}'),
      );
    }
  }

  /// إفراغ السلة بالكامل.
  Future<Either<Failure, List<CartItem>>> clearCart() async {
    try {
      await client.cart.clearCart();

      final items = await _fetchCartItems();
      return Right(items);
    } catch (e) {
      return Left(
        ServerFailure('تعذر إفراغ السلة: ${e.toString()}'),
      );
    }
  }

  /// تحويل سجلات Serverpod إلى CartItem الذي تستخدمه الواجهة.
  Future<List<CartItem>> _fetchCartItems() async {
    final records = await client.cart.getMyCart();

    final items = <CartItem>[];

    for (final record in records) {
      final product = record.product;

      if (product == null || product.id == null) {
        throw StateError(
          'تعذر تحميل بيانات أحد المنتجات الموجودة في السلة.',
        );
      }

      if (record.quantity <= 0) {
        throw StateError('توجد كمية غير صحيحة في السلة.');
      }

      items.add(
        CartItem(
          product: product,
          quantity: record.quantity,
        ),
      );
    }

    return items;
  }
}
