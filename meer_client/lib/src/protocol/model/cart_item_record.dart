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

abstract class CartItemRecord
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CartItemRecord._({
    this.id,
    required this.userId,
    required this.productId,
    this.product,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CartItemRecord({
    int? id,
    required int userId,
    required int productId,
    _im4wswb6.Product? product,
    required int quantity,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CartItemRecordImpl;

  factory CartItemRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return CartItemRecord(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      productId: jsonSerialization['productId'] as int,
      product: jsonSerialization['product'] == null
          ? null
          : _ihjszy8t.Protocol().deserialize<_im4wswb6.Product>(
              jsonSerialization['product'],
            ),
      quantity: jsonSerialization['quantity'] as int,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
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

  int quantity;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [CartItemRecord]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CartItemRecord copyWith({
    int? id,
    int? userId,
    int? productId,
    _im4wswb6.Product? product,
    int? quantity,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CartItemRecord',
      if (id != null) 'id': id,
      'userId': userId,
      'productId': productId,
      if (product != null) 'product': product?.toJson(),
      'quantity': quantity,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CartItemRecord',
      if (id != null) 'id': id,
      'userId': userId,
      'productId': productId,
      if (product != null) 'product': product?.toJsonForProtocol(),
      'quantity': quantity,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CartItemRecordImpl extends CartItemRecord {
  _CartItemRecordImpl({
    int? id,
    required int userId,
    required int productId,
    _im4wswb6.Product? product,
    required int quantity,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         productId: productId,
         product: product,
         quantity: quantity,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [CartItemRecord]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CartItemRecord copyWith({
    Object? id = _Undefined,
    int? userId,
    int? productId,
    Object? product = _Undefined,
    int? quantity,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CartItemRecord(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      product: product is _im4wswb6.Product?
          ? product
          : this.product?.copyWith(),
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
