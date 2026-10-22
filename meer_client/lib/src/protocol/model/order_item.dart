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

abstract class OrderItem
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  OrderItem._({
    this.id,
    required this.orderId,
    required this.productId,
    this.product,
    required this.quantity,
    required this.price,
  });

  factory OrderItem({
    int? id,
    required int orderId,
    required int productId,
    _im4wswb6.Product? product,
    required int quantity,
    required double price,
  }) = _OrderItemImpl;

  factory OrderItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderItem(
      id: jsonSerialization['id'] as int?,
      orderId: jsonSerialization['orderId'] as int,
      productId: jsonSerialization['productId'] as int,
      product: jsonSerialization['product'] == null
          ? null
          : _ihjszy8t.Protocol().deserialize<_im4wswb6.Product>(
              jsonSerialization['product'],
            ),
      quantity: jsonSerialization['quantity'] as int,
      price: (jsonSerialization['price'] as num).toDouble(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int orderId;

  int productId;

  _im4wswb6.Product? product;

  int quantity;

  double price;

  /// Returns a shallow copy of this [OrderItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  OrderItem copyWith({
    int? id,
    int? orderId,
    int? productId,
    _im4wswb6.Product? product,
    int? quantity,
    double? price,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderItem',
      if (id != null) 'id': id,
      'orderId': orderId,
      'productId': productId,
      if (product != null) 'product': product?.toJson(),
      'quantity': quantity,
      'price': price,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OrderItem',
      if (id != null) 'id': id,
      'orderId': orderId,
      'productId': productId,
      if (product != null) 'product': product?.toJsonForProtocol(),
      'quantity': quantity,
      'price': price,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderItemImpl extends OrderItem {
  _OrderItemImpl({
    int? id,
    required int orderId,
    required int productId,
    _im4wswb6.Product? product,
    required int quantity,
    required double price,
  }) : super._(
         id: id,
         orderId: orderId,
         productId: productId,
         product: product,
         quantity: quantity,
         price: price,
       );

  /// Returns a shallow copy of this [OrderItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  OrderItem copyWith({
    Object? id = _Undefined,
    int? orderId,
    int? productId,
    Object? product = _Undefined,
    int? quantity,
    double? price,
  }) {
    return OrderItem(
      id: id is int? ? id : this.id,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      product: product is _im4wswb6.Product?
          ? product
          : this.product?.copyWith(),
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }
}
