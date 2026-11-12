part of 'product_form_bloc.dart';

@freezed
sealed class ProductFormEvent with _$ProductFormEvent {
  const factory ProductFormEvent.submitted({
    required String name,
    required String price,
    String? description,
    String? imageUrl,
    // صورة جديدة اختارها البائع وتحتاج رفعًا قبل الحفظ.
    Uint8List? newImageBytes,
    String? newImageExtension,
  }) = ProductFormSubmitted;
}
