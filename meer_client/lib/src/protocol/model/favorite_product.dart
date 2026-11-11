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

abstract class FavoriteProduct
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FavoriteProduct._({
    this.id,
    required this.userId,
    required this.productId,
    this.product,
    required this.createdAt,
  });

  factory FavoriteProduct({
    int? id,
    required int userId,
    required int productId,
    _im4wswb6.Product? product,
    required DateTime createdAt,
  }) = _FavoriteProductImpl;

  factory FavoriteProduct.fromJson(Map<String, dynamic> jsonSerialization) {
    return FavoriteProduct(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      productId: jsonSerialization['productId'] as int,
      product: jsonSerialization['product'] == null
          ? null
          : _ihjszy8t.Protocol().deserialize<_im4wswb6.Product>(
              jsonSerialization['product'],
            ),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int productId;

  _im4wswb6.Product? product;

  DateTime createdAt;

  /// Returns a shallow copy of this [FavoriteProduct]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FavoriteProduct copyWith({
    int? id,
    int? userId,
    int? productId,
    _im4wswb6.Product? product,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FavoriteProduct',
      if (id != null) 'id': id,
      'userId': userId,
      'productId': productId,
      if (product != null) 'product': product?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FavoriteProduct',
      if (id != null) 'id': id,
      'userId': userId,
      'productId': productId,
      if (product != null) 'product': product?.toJsonForProtocol(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FavoriteProductImpl extends FavoriteProduct {
  _FavoriteProductImpl({
    int? id,
    required int userId,
    required int productId,
    _im4wswb6.Product? product,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         productId: productId,
         product: product,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [FavoriteProduct]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FavoriteProduct copyWith({
    Object? id = _Undefined,
    int? userId,
    int? productId,
    Object? product = _Undefined,
    DateTime? createdAt,
  }) {
    return FavoriteProduct(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      product: product is _im4wswb6.Product?
          ? product
          : this.product?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
