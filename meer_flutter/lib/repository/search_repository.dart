import 'package:fpdart/fpdart.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/client.dart';
import 'package:meer_flutter/core/class/failure.dart';

class SearchRepository {
  /// البحث عن المنتجات المتاحة.
  Future<Either<Failure, List<Product>>> searchResults(
    String search,
  ) async {
    final query = search.trim();

    // لا نرسل طلبًا إلى الخادم إذا كان البحث فارغًا.
    if (query.isEmpty) {
      return Right(<Product>[]);
    }

    try {
      final products = await client.product.searchProducts(
        query,
      );

      return Right(products);
    } catch (error) {
      return Left(
        ServerFailure(
          'تعذر البحث عن المنتجات: ${error.toString()}',
        ),
      );
    }
  }
}
