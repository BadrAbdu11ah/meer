/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:meer_client/src/protocol/protocol.dart' as _ihjszy8t;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../model/product.dart' as _im4wswb6;

abstract class ProductPresentation
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ProductPresentation._({
    required this.product,
    required this.sellerName,
  });

  factory ProductPresentation({
    required _im4wswb6.Product product,
    required String sellerName,
  }) = _ProductPresentationImpl;

  factory ProductPresentation.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProductPresentation(
      product: _ihjszy8t.Protocol().deserialize<_im4wswb6.Product>(
        jsonSerialization['product'],
      ),
      sellerName: jsonSerialization['sellerName'] as String,
    );
  }

  _im4wswb6.Product product;

  String sellerName;

  /// Returns a shallow copy of this [ProductPresentation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ProductPresentation copyWith({
    _im4wswb6.Product? product,
    String? sellerName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProductPresentation',
      'product': product.toJson(),
      'sellerName': sellerName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProductPresentation',
      'product': product.toJsonForProtocol(),
      'sellerName': sellerName,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ProductPresentationImpl extends ProductPresentation {
  _ProductPresentationImpl({
    required _im4wswb6.Product product,
    required String sellerName,
  }) : super._(
         product: product,
         sellerName: sellerName,
       );

  /// Returns a shallow copy of this [ProductPresentation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ProductPresentation copyWith({
    _im4wswb6.Product? product,
    String? sellerName,
  }) {
    return ProductPresentation(
      product: product ?? this.product.copyWith(),
      sellerName: sellerName ?? this.sellerName,
    );
  }
}
