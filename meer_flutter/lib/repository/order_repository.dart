import 'package:fpdart/fpdart.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/client.dart';
import 'package:meer_flutter/core/class/failure.dart';

class OrderRepository {
  /// إنشاء طلب جديد للمشتري الحالي.
  Future<Either<Failure, OrderInfo>> createOrder({
    required List<OrderItemRequest> items,
    required String deliveryAddress,
    double? deliveryLatitude,
    double? deliveryLongitude,
  }) async {
    try {
      final order = await client.order.createOrder(
        items,
        deliveryAddress,
        deliveryLatitude,
        deliveryLongitude,
      );

      return Right(order);
    } catch (error) {
      return Left(
        ServerFailure(
          'تعذر إنشاء الطلب: ${error.toString()}',
        ),
      );
    }
  }

  /// جلب طلبات المشتري الحالي.
  Future<Either<Failure, List<OrderInfo>>> getMyCustomerOrders() async {
    try {
      final orders = await client.order.getMyCustomerOrders();

      return Right(orders);
    } catch (error) {
      return Left(
        ServerFailure(
          'تعذر تحميل طلباتك: ${error.toString()}',
        ),
      );
    }
  }

  /// جلب الطلبات الواردة للبائع الحالي.
  Future<Either<Failure, List<OrderInfo>>> getMySellerOrders() async {
    try {
      final orders = await client.order.getMySellerOrders();

      return Right(orders);
    } catch (error) {
      return Left(
        ServerFailure(
          'تعذر تحميل الطلبات الواردة: ${error.toString()}',
        ),
      );
    }
  }

  /// قبول الطلب.
  Future<Either<Failure, bool>> acceptMyOrder(
    int orderId,
  ) async {
    return _executeOrderAction(
      action: () => client.order.acceptMyOrder(orderId),
      failureMessage: 'تعذر قبول الطلب.',
    );
  }

  /// رفض الطلب.
  Future<Either<Failure, bool>> rejectMyOrder(
    int orderId,
  ) async {
    return _executeOrderAction(
      action: () => client.order.rejectMyOrder(orderId),
      failureMessage: 'تعذر رفض الطلب.',
    );
  }

  /// تأكيد جاهزية الطلب.
  Future<Either<Failure, bool>> markMyOrderReady(
    int orderId,
  ) async {
    return _executeOrderAction(
      action: () => client.order.markMyOrderReady(orderId),
      failureMessage: 'تعذر تحديث حالة الطلب.',
    );
  }

  Future<Either<Failure, bool>> _executeOrderAction({
    required Future<bool> Function() action,
    required String failureMessage,
  }) async {
    try {
      final success = await action();

      if (!success) {
        return Left(
          ServerFailure(
            'لم يتم تحديث الطلب. ربما تغيرت حالته بالفعل.',
          ),
        );
      }

      return const Right(true);
    } catch (error) {
      return Left(
        ServerFailure(
          '$failureMessage ${error.toString()}',
        ),
      );
    }
  }
}
