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
import '../model/order_item.dart' as _ixwt4bxc;
import '../model/user.dart' as _ii4paws6;

abstract class OrderInfo
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  OrderInfo._({
    this.id,
    required this.customerId,
    this.customer,
    required this.sellerId,
    this.seller,
    this.driverId,
    required this.status,
    required this.totalAmount,
    required this.deliveryAddress,
    this.deliveryLatitude,
    this.deliveryLongitude,
    required this.createdAt,
    this.items,
  });

  factory OrderInfo({
    int? id,
    required int customerId,
    _ii4paws6.User? customer,
    required int sellerId,
    _ii4paws6.User? seller,
    int? driverId,
    required String status,
    required double totalAmount,
    required String deliveryAddress,
    double? deliveryLatitude,
    double? deliveryLongitude,
    required DateTime createdAt,
    List<_ixwt4bxc.OrderItem>? items,
  }) = _OrderInfoImpl;

  factory OrderInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderInfo(
      id: jsonSerialization['id'] as int?,
      customerId: jsonSerialization['customerId'] as int,
      customer: jsonSerialization['customer'] == null
          ? null
          : _ihjszy8t.Protocol().deserialize<_ii4paws6.User>(
              jsonSerialization['customer'],
            ),
      sellerId: jsonSerialization['sellerId'] as int,
      seller: jsonSerialization['seller'] == null
          ? null
          : _ihjszy8t.Protocol().deserialize<_ii4paws6.User>(
              jsonSerialization['seller'],
            ),
      driverId: jsonSerialization['driverId'] as int?,
      status: jsonSerialization['status'] as String,
      totalAmount: (jsonSerialization['totalAmount'] as num).toDouble(),
      deliveryAddress: jsonSerialization['deliveryAddress'] as String,
      deliveryLatitude: (jsonSerialization['deliveryLatitude'] as num?)
          ?.toDouble(),
      deliveryLongitude: (jsonSerialization['deliveryLongitude'] as num?)
          ?.toDouble(),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      items: jsonSerialization['items'] == null
          ? null
          : _ihjszy8t.Protocol().deserialize<List<_ixwt4bxc.OrderItem>>(
              jsonSerialization['items'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int customerId;

  _ii4paws6.User? customer;

  int sellerId;

  _ii4paws6.User? seller;

  int? driverId;

  String status;

  double totalAmount;

  String deliveryAddress;

  double? deliveryLatitude;

  double? deliveryLongitude;

  DateTime createdAt;

  List<_ixwt4bxc.OrderItem>? items;

  /// Returns a shallow copy of this [OrderInfo]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  OrderInfo copyWith({
    int? id,
    int? customerId,
    _ii4paws6.User? customer,
    int? sellerId,
    _ii4paws6.User? seller,
    int? driverId,
    String? status,
    double? totalAmount,
    String? deliveryAddress,
    double? deliveryLatitude,
    double? deliveryLongitude,
    DateTime? createdAt,
    List<_ixwt4bxc.OrderItem>? items,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderInfo',
      if (id != null) 'id': id,
      'customerId': customerId,
      if (customer != null) 'customer': customer?.toJson(),
      'sellerId': sellerId,
      if (seller != null) 'seller': seller?.toJson(),
      if (driverId != null) 'driverId': driverId,
      'status': status,
      'totalAmount': totalAmount,
      'deliveryAddress': deliveryAddress,
      if (deliveryLatitude != null) 'deliveryLatitude': deliveryLatitude,
      if (deliveryLongitude != null) 'deliveryLongitude': deliveryLongitude,
      'createdAt': createdAt.toJson(),
      if (items != null) 'items': items?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OrderInfo',
      if (id != null) 'id': id,
      'customerId': customerId,
      if (customer != null) 'customer': customer?.toJsonForProtocol(),
      'sellerId': sellerId,
      if (seller != null) 'seller': seller?.toJsonForProtocol(),
      if (driverId != null) 'driverId': driverId,
      'status': status,
      'totalAmount': totalAmount,
      'deliveryAddress': deliveryAddress,
      if (deliveryLatitude != null) 'deliveryLatitude': deliveryLatitude,
      if (deliveryLongitude != null) 'deliveryLongitude': deliveryLongitude,
      'createdAt': createdAt.toJson(),
      if (items != null)
        'items': items?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrderInfoImpl extends OrderInfo {
  _OrderInfoImpl({
    int? id,
    required int customerId,
    _ii4paws6.User? customer,
    required int sellerId,
    _ii4paws6.User? seller,
    int? driverId,
    required String status,
    required double totalAmount,
    required String deliveryAddress,
    double? deliveryLatitude,
    double? deliveryLongitude,
    required DateTime createdAt,
    List<_ixwt4bxc.OrderItem>? items,
  }) : super._(
         id: id,
         customerId: customerId,
         customer: customer,
         sellerId: sellerId,
         seller: seller,
         driverId: driverId,
         status: status,
         totalAmount: totalAmount,
         deliveryAddress: deliveryAddress,
         deliveryLatitude: deliveryLatitude,
         deliveryLongitude: deliveryLongitude,
         createdAt: createdAt,
         items: items,
       );

  /// Returns a shallow copy of this [OrderInfo]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  OrderInfo copyWith({
    Object? id = _Undefined,
    int? customerId,
    Object? customer = _Undefined,
    int? sellerId,
    Object? seller = _Undefined,
    Object? driverId = _Undefined,
    String? status,
    double? totalAmount,
    String? deliveryAddress,
    Object? deliveryLatitude = _Undefined,
    Object? deliveryLongitude = _Undefined,
    DateTime? createdAt,
    Object? items = _Undefined,
  }) {
    return OrderInfo(
      id: id is int? ? id : this.id,
      customerId: customerId ?? this.customerId,
      customer: customer is _ii4paws6.User?
          ? customer
          : this.customer?.copyWith(),
      sellerId: sellerId ?? this.sellerId,
      seller: seller is _ii4paws6.User? ? seller : this.seller?.copyWith(),
      driverId: driverId is int? ? driverId : this.driverId,
      status: status ?? this.status,
      totalAmount: totalAmount ?? this.totalAmount,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      deliveryLatitude: deliveryLatitude is double?
          ? deliveryLatitude
          : this.deliveryLatitude,
      deliveryLongitude: deliveryLongitude is double?
          ? deliveryLongitude
          : this.deliveryLongitude,
      createdAt: createdAt ?? this.createdAt,
      items: items is List<_ixwt4bxc.OrderItem>?
          ? items
          : this.items?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
