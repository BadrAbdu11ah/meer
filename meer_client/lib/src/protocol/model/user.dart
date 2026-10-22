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

abstract class User
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  User._({
    this.id,
    this.authUserId,
    this.authUser,
    required this.fullName,
    required this.phone,
    this.email,
    required this.role,
    this.address,
    this.latitude,
    this.longitude,
    required this.createdAt,
  });

  factory User({
    int? id,
    _isc.UuidValue? authUserId,
    _iacc.AuthUser? authUser,
    required String fullName,
    required String phone,
    String? email,
    required String role,
    String? address,
    double? latitude,
    double? longitude,
    required DateTime createdAt,
  }) = _UserImpl;

  factory User.fromJson(Map<String, dynamic> jsonSerialization) {
    return User(
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
      address: jsonSerialization['address'] as String?,
      latitude: (jsonSerialization['latitude'] as num?)?.toDouble(),
      longitude: (jsonSerialization['longitude'] as num?)?.toDouble(),
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

  /// ربط المستخدم بحساب المصادقة في Serverpod
  _iacc.AuthUser? authUser;

  String fullName;

  String phone;

  String? email;

  String role;

  String? address;

  double? latitude;

  double? longitude;

  DateTime createdAt;

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  User copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    _iacc.AuthUser? authUser,
    String? fullName,
    String? phone,
    String? email,
    String? role,
    String? address,
    double? latitude,
    double? longitude,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'User',
      if (id != null) 'id': id,
      if (authUserId != null) 'authUserId': authUserId?.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'fullName': fullName,
      'phone': phone,
      if (email != null) 'email': email,
      'role': role,
      if (address != null) 'address': address,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'User',
      if (id != null) 'id': id,
      if (authUserId != null) 'authUserId': authUserId?.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'fullName': fullName,
      'phone': phone,
      if (email != null) 'email': email,
      'role': role,
      if (address != null) 'address': address,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserImpl extends User {
  _UserImpl({
    int? id,
    _isc.UuidValue? authUserId,
    _iacc.AuthUser? authUser,
    required String fullName,
    required String phone,
    String? email,
    required String role,
    String? address,
    double? latitude,
    double? longitude,
    required DateTime createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         fullName: fullName,
         phone: phone,
         email: email,
         role: role,
         address: address,
         latitude: latitude,
         longitude: longitude,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  User copyWith({
    Object? id = _Undefined,
    Object? authUserId = _Undefined,
    Object? authUser = _Undefined,
    String? fullName,
    String? phone,
    Object? email = _Undefined,
    String? role,
    Object? address = _Undefined,
    Object? latitude = _Undefined,
    Object? longitude = _Undefined,
    DateTime? createdAt,
  }) {
    return User(
      id: id is int? ? id : this.id,
      authUserId: authUserId is _isc.UuidValue? ? authUserId : this.authUserId,
      authUser: authUser is _iacc.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      email: email is String? ? email : this.email,
      role: role ?? this.role,
      address: address is String? ? address : this.address,
      latitude: latitude is double? ? latitude : this.latitude,
      longitude: longitude is double? ? longitude : this.longitude,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
