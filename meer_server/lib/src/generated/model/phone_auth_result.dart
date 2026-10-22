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
import '../model/user.dart' as _ii4paws6;

abstract class PhoneAuthResult
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PhoneAuthResult._({
    required this.success,
    this.keyId,
    this.key,
    this.user,
  });

  factory PhoneAuthResult({
    required bool success,
    int? keyId,
    String? key,
    _ii4paws6.User? user,
  }) = _PhoneAuthResultImpl;

  factory PhoneAuthResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return PhoneAuthResult(
      success: _is.BoolJsonExtension.fromJson(jsonSerialization['success']),
      keyId: jsonSerialization['keyId'] as int?,
      key: jsonSerialization['key'] as String?,
      user: jsonSerialization['user'] == null
          ? null
          : _i58zzwu7.Protocol().deserialize<_ii4paws6.User>(
              jsonSerialization['user'],
            ),
    );
  }

  bool success;

  int? keyId;

  String? key;

  _ii4paws6.User? user;

  /// Returns a shallow copy of this [PhoneAuthResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PhoneAuthResult copyWith({
    bool? success,
    int? keyId,
    String? key,
    _ii4paws6.User? user,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PhoneAuthResult',
      'success': success,
      if (keyId != null) 'keyId': keyId,
      if (key != null) 'key': key,
      if (user != null) 'user': user?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PhoneAuthResult',
      'success': success,
      if (keyId != null) 'keyId': keyId,
      if (key != null) 'key': key,
      if (user != null) 'user': user?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PhoneAuthResultImpl extends PhoneAuthResult {
  _PhoneAuthResultImpl({
    required bool success,
    int? keyId,
    String? key,
    _ii4paws6.User? user,
  }) : super._(
         success: success,
         keyId: keyId,
         key: key,
         user: user,
       );

  /// Returns a shallow copy of this [PhoneAuthResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PhoneAuthResult copyWith({
    bool? success,
    Object? keyId = _Undefined,
    Object? key = _Undefined,
    Object? user = _Undefined,
  }) {
    return PhoneAuthResult(
      success: success ?? this.success,
      keyId: keyId is int? ? keyId : this.keyId,
      key: key is String? ? key : this.key,
      user: user is _ii4paws6.User? ? user : this.user?.copyWith(),
    );
  }
}
