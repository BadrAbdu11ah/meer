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
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class MeerUserProfile
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MeerUserProfile._({
    this.id,
    this.authUserId,
    this.authUser,
    required this.fullName,
    required this.phone,
    this.email,
    required this.role,
    bool? isSeller,
    this.address,
    this.latitude,
    this.longitude,
    this.storeName,
    this.storeDescription,
    this.storeAddress,
    this.storeLatitude,
    this.storeLongitude,
    required this.createdAt,
  }) : isSeller = isSeller ?? false;

  factory MeerUserProfile({
    int? id,
    _isc.UuidValue? authUserId,
    _iacc.AuthUser? authUser,
    required String fullName,
    required String phone,
    String? email,
    required String role,
    bool? isSeller,
    String? address,
    double? latitude,
    double? longitude,
    String? storeName,
    String? storeDescription,
    String? storeAddress,
    double? storeLatitude,
    double? storeLongitude,
    required DateTime createdAt,
  }) = _MeerUserProfileImpl;

  factory MeerUserProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return MeerUserProfile(
      id: jsonSerialization['id'] as int?,
      authUserId: jsonSerialization['authUserId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['authUserId'],
            ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _ihjszy8t.Protocol().deserialize<_iacc.AuthUser>(
              jsonSerialization['authUser'],
            ),
      fullName: jsonSerialization['fullName'] as String,
      phone: jsonSerialization['phone'] as String,
      email: jsonSerialization['email'] as String?,
      role: jsonSerialization['role'] as String,
      isSeller: jsonSerialization['isSeller'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isSeller']),
      address: jsonSerialization['address'] as String?,
      latitude: (jsonSerialization['latitude'] as num?)?.toDouble(),
      longitude: (jsonSerialization['longitude'] as num?)?.toDouble(),
      storeName: jsonSerialization['storeName'] as String?,
      storeDescription: jsonSerialization['storeDescription'] as String?,
      storeAddress: jsonSerialization['storeAddress'] as String?,
      storeLatitude: (jsonSerialization['storeLatitude'] as num?)?.toDouble(),
      storeLongitude: (jsonSerialization['storeLongitude'] as num?)?.toDouble(),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue? authUserId;

  _iacc.AuthUser? authUser;

  String fullName;

  String phone;

  String? email;

  String role;

  bool isSeller;

  String? address;

  double? latitude;

  double? longitude;

  String? storeName;

  String? storeDescription;

  String? storeAddress;

  double? storeLatitude;

  double? storeLongitude;

  DateTime createdAt;

  /// Returns a shallow copy of this [MeerUserProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MeerUserProfile copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    _iacc.AuthUser? authUser,
    String? fullName,
    String? phone,
    String? email,
    String? role,
    bool? isSeller,
    String? address,
    double? latitude,
    double? longitude,
    String? storeName,
    String? storeDescription,
    String? storeAddress,
    double? storeLatitude,
    double? storeLongitude,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MeerUserProfile',
      if (id != null) 'id': id,
      if (authUserId != null) 'authUserId': authUserId?.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'fullName': fullName,
      'phone': phone,
      if (email != null) 'email': email,
      'role': role,
      'isSeller': isSeller,
      if (address != null) 'address': address,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (storeName != null) 'storeName': storeName,
      if (storeDescription != null) 'storeDescription': storeDescription,
      if (storeAddress != null) 'storeAddress': storeAddress,
      if (storeLatitude != null) 'storeLatitude': storeLatitude,
      if (storeLongitude != null) 'storeLongitude': storeLongitude,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MeerUserProfile',
      if (id != null) 'id': id,
      if (authUserId != null) 'authUserId': authUserId?.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'fullName': fullName,
      'phone': phone,
      if (email != null) 'email': email,
      'role': role,
      'isSeller': isSeller,
      if (address != null) 'address': address,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (storeName != null) 'storeName': storeName,
      if (storeDescription != null) 'storeDescription': storeDescription,
      if (storeAddress != null) 'storeAddress': storeAddress,
      if (storeLatitude != null) 'storeLatitude': storeLatitude,
      if (storeLongitude != null) 'storeLongitude': storeLongitude,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MeerUserProfileImpl extends MeerUserProfile {
  _MeerUserProfileImpl({
    int? id,
    _isc.UuidValue? authUserId,
    _iacc.AuthUser? authUser,
    required String fullName,
    required String phone,
    String? email,
    required String role,
    bool? isSeller,
    String? address,
    double? latitude,
    double? longitude,
    String? storeName,
    String? storeDescription,
    String? storeAddress,
    double? storeLatitude,
    double? storeLongitude,
    required DateTime createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         fullName: fullName,
         phone: phone,
         email: email,
         role: role,
         isSeller: isSeller,
         address: address,
         latitude: latitude,
         longitude: longitude,
         storeName: storeName,
         storeDescription: storeDescription,
         storeAddress: storeAddress,
         storeLatitude: storeLatitude,
         storeLongitude: storeLongitude,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [MeerUserProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MeerUserProfile copyWith({
    Object? id = _Undefined,
    Object? authUserId = _Undefined,
    Object? authUser = _Undefined,
    String? fullName,
    String? phone,
    Object? email = _Undefined,
    String? role,
    bool? isSeller,
    Object? address = _Undefined,
    Object? latitude = _Undefined,
    Object? longitude = _Undefined,
    Object? storeName = _Undefined,
    Object? storeDescription = _Undefined,
    Object? storeAddress = _Undefined,
    Object? storeLatitude = _Undefined,
    Object? storeLongitude = _Undefined,
    DateTime? createdAt,
  }) {
    return MeerUserProfile(
      id: id is int? ? id : this.id,
      authUserId: authUserId is _isc.UuidValue? ? authUserId : this.authUserId,
      authUser: authUser is _iacc.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      email: email is String? ? email : this.email,
      role: role ?? this.role,
      isSeller: isSeller ?? this.isSeller,
      address: address is String? ? address : this.address,
      latitude: latitude is double? ? latitude : this.latitude,
      longitude: longitude is double? ? longitude : this.longitude,
      storeName: storeName is String? ? storeName : this.storeName,
      storeDescription: storeDescription is String?
          ? storeDescription
          : this.storeDescription,
      storeAddress: storeAddress is String? ? storeAddress : this.storeAddress,
      storeLatitude: storeLatitude is double?
          ? storeLatitude
          : this.storeLatitude,
      storeLongitude: storeLongitude is double?
          ? storeLongitude
          : this.storeLongitude,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
