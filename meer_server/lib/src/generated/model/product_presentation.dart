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
import 'package:meer_server/src/generated/protocol.dart' as _i58zzwu7;
import 'package:serverpod/serverpod.dart' as _is;
import '../model/product.dart' as _im4wswb6;

abstract class ProductPresentation
    implements _is.SerializableModel, _is.ProtocolSerialization {
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
      product: _i58zzwu7.Protocol().deserialize<_im4wswb6.Product>(
        jsonSerialization['product'],
      ),
      sellerName: jsonSerialization['sellerName'] as String,
    );
  }

  _im4wswb6.Product product;

  String sellerName;

  /// Returns a shallow copy of this [ProductPresentation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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
