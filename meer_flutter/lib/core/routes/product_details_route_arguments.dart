import 'package:meer_client/meer_client.dart';

class ProductDetailsRouteArguments {
  const ProductDetailsRouteArguments({
    required this.product,
    required this.sellerName,
  });

  final Product product;
  final String sellerName;
}
