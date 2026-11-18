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

abstract class UserDeviceInstallation
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  UserDeviceInstallation._({
    this.id,
    required this.authUserId,
    required this.installationId,
    required this.platform,
    DateTime? createdAt,
    DateTime? lastSeenAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       lastSeenAt = lastSeenAt ?? DateTime.now();

  factory UserDeviceInstallation({
    int? id,
    required _isc.UuidValue authUserId,
    required String installationId,
    required String platform,
    DateTime? createdAt,
    DateTime? lastSeenAt,
  }) = _UserDeviceInstallationImpl;

  factory UserDeviceInstallation.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return UserDeviceInstallation(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      installationId: jsonSerialization['installationId'] as String,
      platform: jsonSerialization['platform'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      lastSeenAt: jsonSerialization['lastSeenAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastSeenAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  String installationId;

  String platform;

  DateTime createdAt;

  DateTime lastSeenAt;

  /// Returns a shallow copy of this [UserDeviceInstallation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  UserDeviceInstallation copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? installationId,
    String? platform,
    DateTime? createdAt,
    DateTime? lastSeenAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserDeviceInstallation',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'installationId': installationId,
      'platform': platform,
      'createdAt': createdAt.toJson(),
      'lastSeenAt': lastSeenAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserDeviceInstallation',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'installationId': installationId,
      'platform': platform,
      'createdAt': createdAt.toJson(),
      'lastSeenAt': lastSeenAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserDeviceInstallationImpl extends UserDeviceInstallation {
  _UserDeviceInstallationImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String installationId,
    required String platform,
    DateTime? createdAt,
    DateTime? lastSeenAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         installationId: installationId,
         platform: platform,
         createdAt: createdAt,
         lastSeenAt: lastSeenAt,
       );

  /// Returns a shallow copy of this [UserDeviceInstallation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  UserDeviceInstallation copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? installationId,
    String? platform,
    DateTime? createdAt,
    DateTime? lastSeenAt,
  }) {
    return UserDeviceInstallation(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      installationId: installationId ?? this.installationId,
      platform: platform ?? this.platform,
      createdAt: createdAt ?? this.createdAt,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
    );
  }
}
