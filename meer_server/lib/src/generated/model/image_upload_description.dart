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
import 'package:serverpod/serverpod.dart' as _is;

abstract class ImageUploadDescription
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ImageUploadDescription._({
    required this.filePath,
    required this.uploadDescription,
  });

  factory ImageUploadDescription({
    required String filePath,
    required String uploadDescription,
  }) = _ImageUploadDescriptionImpl;

  factory ImageUploadDescription.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ImageUploadDescription(
      filePath: jsonSerialization['filePath'] as String,
      uploadDescription: jsonSerialization['uploadDescription'] as String,
    );
  }

  String filePath;

  String uploadDescription;

  /// Returns a shallow copy of this [ImageUploadDescription]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ImageUploadDescription copyWith({
    String? filePath,
    String? uploadDescription,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ImageUploadDescription',
      'filePath': filePath,
      'uploadDescription': uploadDescription,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ImageUploadDescription',
      'filePath': filePath,
      'uploadDescription': uploadDescription,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ImageUploadDescriptionImpl extends ImageUploadDescription {
  _ImageUploadDescriptionImpl({
    required String filePath,
    required String uploadDescription,
  }) : super._(
         filePath: filePath,
         uploadDescription: uploadDescription,
       );

  /// Returns a shallow copy of this [ImageUploadDescription]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ImageUploadDescription copyWith({
    String? filePath,
    String? uploadDescription,
  }) {
    return ImageUploadDescription(
      filePath: filePath ?? this.filePath,
      uploadDescription: uploadDescription ?? this.uploadDescription,
    );
  }
}
