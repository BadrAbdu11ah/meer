import 'package:fpdart/fpdart.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/client.dart';
import 'package:meer_flutter/core/class/failure.dart';

class SellerRepository {
  // 1.
  /// جلب المعلومات العامة لأسرة منتجة محددة.
  Future<Either<Failure, SellerPublicInfo>> getPublicSellerInfo({
    required int sellerId,
  }) async {
    try {
      final seller = await client.seller.getPublicSellerInfo(
        sellerId,
      );

      return Right(seller);
    } catch (error) {
      return Left(
        ServerFailure(
          'تعذر تحميل معلومات الأسرة المنتجة: ${error.toString()}',
        ),
      );
    }
  }

  // 2.
  /// تفعيل حساب البائع
  Future<Either<Failure, MeerUserProfile>> activateSeller({
    required String storeName,
    required String storeAddress,
    required MeerCity city,
    String? district,
    required double latitude,
    required double longitude,
    String? storeDescription,
  }) async {
    try {
      final profile = await client.seller.activateSeller(
        storeName,
        storeDescription,
        storeAddress,
        city,
        district,
        latitude,
        longitude,
      );

      return Right(profile);
    } catch (error) {
      return Left(
        ServerFailure(
          'تعذر تفعيل البيع: ${error.toString()}',
        ),
      );
    }
  }

  // 3.
  /// جلب ملف المستخدم الحالي.
  Future<Either<Failure, MeerUserProfile>> getMyProfile() async {
    try {
      final profile = await client.seller.getMyProfile();

      return Right(profile);
    } catch (error) {
      return Left(
        ServerFailure(
          'تعذر تحميل بيانات الحساب: ${error.toString()}',
        ),
      );
    }
  }
}
