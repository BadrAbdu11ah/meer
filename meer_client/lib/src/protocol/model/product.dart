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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class Product
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Product._({
    this.id,
    required this.sellerId,
    required this.name,
    this.description,
    required this.price,
    this.imageUrl,
    required this.isAvailable,
    required this.createdAt,
  });

  factory Product({
    int? id,
    required int sellerId,
    required String name,
    String? description,
    required double price,
    String? imageUrl,
    required bool isAvailable,
    required DateTime createdAt,
  }) = _ProductImpl;

  factory Product.fromJson(Map<String, dynamic> jsonSerialization) {
    return Product(
      id: jsonSerialization['id'] as int?,
      sellerId: jsonSerialization['sellerId'] as int,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      price: (jsonSerialization['price'] as num).toDouble(),
      imageUrl: jsonSerialization['imageUrl'] as String?,
      isAvailable: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['isAvailable'],
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

  int sellerId;

  String name;

  String? description;

  double price;

  String? imageUrl;

  bool isAvailable;

  DateTime createdAt;

  /// Returns a shallow copy of this [Product]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Product copyWith({
    int? id,
    int? sellerId,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    bool? isAvailable,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Product',
      if (id != null) 'id': id,
      'sellerId': sellerId,
      'name': name,
      if (description != null) 'description': description,
      'price': price,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'isAvailable': isAvailable,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Product',
      if (id != null) 'id': id,
      'sellerId': sellerId,
      'name': name,
      if (description != null) 'description': description,
      'price': price,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'isAvailable': isAvailable,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProductImpl extends Product {
  _ProductImpl({
    int? id,
    required int sellerId,
    required String name,
    String? description,
    required double price,
    String? imageUrl,
    required bool isAvailable,
    required DateTime createdAt,
  }) : super._(
         id: id,
         sellerId: sellerId,
         name: name,
         description: description,
         price: price,
         imageUrl: imageUrl,
         isAvailable: isAvailable,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Product]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Product copyWith({
    Object? id = _Undefined,
    int? sellerId,
    String? name,
    Object? description = _Undefined,
    double? price,
    Object? imageUrl = _Undefined,
    bool? isAvailable,
    DateTime? createdAt,
  }) {
    return Product(
      id: id is int? ? id : this.id,
      sellerId: sellerId ?? this.sellerId,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      price: price ?? this.price,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      isAvailable: isAvailable ?? this.isAvailable,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
