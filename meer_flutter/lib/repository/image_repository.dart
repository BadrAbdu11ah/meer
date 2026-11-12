import 'dart:typed_data';

import 'package:fpdart/fpdart.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/client.dart';
import 'package:meer_flutter/core/class/failure.dart';

class ImageRepository {
  ImageRepository();

  /// رفع صورة منتج إلى الخادم، ويرجع رابط الصورة بعد نجاح الرفع.
  Future<Either<Failure, String>> uploadProductImage({
    required Uint8List bytes,
    required String extension,
  }) async {
    try {
      final description = await client.image.createProductImageUpload(
        extension,
      );

      final uploader = FileUploader(description.uploadDescription);

      final uploaded = await uploader.uploadByteData(
        ByteData.sublistView(bytes),
      );

      if (!uploaded) {
        return Left(
          ServerFailure('تعذر رفع الصورة. حاول مرة أخرى.'),
        );
      }

      final url = await client.image.verifyProductImageUpload(
        description.filePath,
      );

      return Right(url);
    } catch (error) {
      return Left(
        ServerFailure('تعذر رفع الصورة: ${error.toString()}'),
      );
    }
  }
}
