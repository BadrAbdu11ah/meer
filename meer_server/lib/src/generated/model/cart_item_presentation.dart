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

abstract class CartItemPresentation
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CartItemPresentation._({
    required this.product,
    required this.quantity,
    required this.sellerName,
  });

  factory CartItemPresentation({
    required _im4wswb6.Product product,
    required int quantity,
    required String sellerName,
  }) = _CartItemPresentationImpl;

  factory CartItemPresentation.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CartItemPresentation(
      product: _i58zzwu7.Protocol().deserialize<_im4wswb6.Product>(
        jsonSerialization['product'],
      ),
      quantity: jsonSerialization['quantity'] as int,
      sellerName: jsonSerialization['sellerName'] as String,
    );
  }

  _im4wswb6.Product product;

  int quantity;

  String sellerName;

  /// Returns a shallow copy of this [CartItemPresentation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CartItemPresentation copyWith({
    _im4wswb6.Product? product,
    int? quantity,
    String? sellerName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CartItemPresentation',
      'product': product.toJson(),
      'quantity': quantity,
      'sellerName': sellerName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CartItemPresentation',
      'product': product.toJsonForProtocol(),
      'quantity': quantity,
      'sellerName': sellerName,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _CartItemPresentationImpl extends CartItemPresentation {
  _CartItemPresentationImpl({
    required _im4wswb6.Product product,
    required int quantity,
    required String sellerName,
  }) : super._(
         product: product,
         quantity: quantity,
         sellerName: sellerName,
       );

  /// Returns a shallow copy of this [CartItemPresentation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CartItemPresentation copyWith({
    _im4wswb6.Product? product,
    int? quantity,
    String? sellerName,
  }) {
    return CartItemPresentation(
      product: product ?? this.product.copyWith(),
      quantity: quantity ?? this.quantity,
      sellerName: sellerName ?? this.sellerName,
    );
  }
}
