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

abstract class SellerPublicInfo
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SellerPublicInfo._({
    required this.sellerId,
    required this.storeName,
    this.storeDescription,
    required this.offersDelivery,
    required this.deliveryFee,
  });

  factory SellerPublicInfo({
    required int sellerId,
    required String storeName,
    String? storeDescription,
    required bool offersDelivery,
    required double deliveryFee,
  }) = _SellerPublicInfoImpl;

  factory SellerPublicInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return SellerPublicInfo(
      sellerId: jsonSerialization['sellerId'] as int,
      storeName: jsonSerialization['storeName'] as String,
      storeDescription: jsonSerialization['storeDescription'] as String?,
      offersDelivery: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['offersDelivery'],
      ),
      deliveryFee: (jsonSerialization['deliveryFee'] as num).toDouble(),
    );
  }

  int sellerId;

  String storeName;

  String? storeDescription;

  bool offersDelivery;

  double deliveryFee;

  /// Returns a shallow copy of this [SellerPublicInfo]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SellerPublicInfo copyWith({
    int? sellerId,
    String? storeName,
    String? storeDescription,
    bool? offersDelivery,
    double? deliveryFee,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SellerPublicInfo',
      'sellerId': sellerId,
      'storeName': storeName,
      if (storeDescription != null) 'storeDescription': storeDescription,
      'offersDelivery': offersDelivery,
      'deliveryFee': deliveryFee,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SellerPublicInfo',
      'sellerId': sellerId,
      'storeName': storeName,
      if (storeDescription != null) 'storeDescription': storeDescription,
      'offersDelivery': offersDelivery,
      'deliveryFee': deliveryFee,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SellerPublicInfoImpl extends SellerPublicInfo {
  _SellerPublicInfoImpl({
    required int sellerId,
    required String storeName,
    String? storeDescription,
    required bool offersDelivery,
    required double deliveryFee,
  }) : super._(
         sellerId: sellerId,
         storeName: storeName,
         storeDescription: storeDescription,
         offersDelivery: offersDelivery,
         deliveryFee: deliveryFee,
       );

  /// Returns a shallow copy of this [SellerPublicInfo]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SellerPublicInfo copyWith({
    int? sellerId,
    String? storeName,
    Object? storeDescription = _Undefined,
    bool? offersDelivery,
    double? deliveryFee,
  }) {
    return SellerPublicInfo(
      sellerId: sellerId ?? this.sellerId,
      storeName: storeName ?? this.storeName,
      storeDescription: storeDescription is String?
          ? storeDescription
          : this.storeDescription,
      offersDelivery: offersDelivery ?? this.offersDelivery,
      deliveryFee: deliveryFee ?? this.deliveryFee,
    );
  }
}
