import 'package:fpdart/fpdart.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/client.dart';
import 'package:meer_flutter/core/class/failure.dart';
import 'package:meer_flutter/repository/local/city_local_repository.dart';

class SearchRepository {
  final CityLocalRepository _cityRepository;

  SearchRepository(this._cityRepository);

  /// البحث عن المنتجات المتاحة في المدينة المختارة.
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
        _cityRepository.current,
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
