import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meer_client/meer_client.dart';

typedef ProductFormSubmitCallback =
    void Function({
      required String name,
      required String price,
      String? description,
      String? imageUrl,
      Uint8List? newImageBytes,
      String? newImageExtension,
    });

class ProductFormView extends StatefulWidget {
  final Product? initialProduct;
  const ProductFormView({
    super.key,
    required this.isSubmitting,
    required this.onSubmit,
    this.initialProduct,
  });

  final bool isSubmitting;
  final ProductFormSubmitCallback onSubmit;

  @override
  State<ProductFormView> createState() => _ProductFormViewState();
}

class _ProductFormViewState extends State<ProductFormView> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _imagePicker = ImagePicker();

  // رابط الصورة الحالية للمنتج (عند التعديل).
  String? _currentImageUrl;

  // صورة جديدة اختارها البائع ولم تُرفع بعد.
  Uint8List? _pickedImageBytes;
  String? _pickedImageExtension;

  static const _allowedExtensions = {'jpg', 'jpeg', 'png', 'webp'};
  static const _maxImageBytes = 5 * 1024 * 1024;

  @override
  void initState() {
    super.initState();

    final product = widget.initialProduct;

    if (product != null) {
      _nameController.text = product.name;
      _descriptionController.text = product.description ?? '';
      _priceController.text = product.price.toString();
      _currentImageUrl = product.imageUrl;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _submit() {
    if (widget.isSubmitting) return;

    if (!_formKey.currentState!.validate()) return;

    widget.onSubmit(
      name: _nameController.text,
      price: _priceController.text,
      description: _descriptionController.text,
      imageUrl: _currentImageUrl,
      newImageBytes: _pickedImageBytes,
      newImageExtension: _pickedImageExtension,
    );
  }

  /// امتداد الملف بحروف صغيرة، والافتراضي jpg.
  String _extensionOf(String fileName) {
    final dotIndex = fileName.lastIndexOf('.');

    if (dotIndex == -1 || dotIndex == fileName.length - 1) return 'jpg';

    final extension = fileName.substring(dotIndex + 1).toLowerCase();

    return _allowedExtensions.contains(extension) ? extension : 'jpg';
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _pickImage(ImageSource source) async {
    if (widget.isSubmitting) return;

    try {
      // نصغّر الصورة قبل الرفع لتبقى سريعة وخفيفة.
      final file = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1280,
        maxHeight: 1280,
        imageQuality: 80,
      );

      if (file == null) return;

      final bytes = await file.readAsBytes();

      if (bytes.length > _maxImageBytes) {
        if (!mounted) return;
        _showMessage('حجم الصورة كبير. اختر صورة أصغر من 5 ميجابايت.');
        return;
      }

      if (!mounted) return;

      setState(() {
        _pickedImageBytes = bytes;
        _pickedImageExtension = _extensionOf(file.name);
      });
    } catch (_) {
      if (!mounted) return;
      _showMessage('تعذر اختيار الصورة. تأكد من السماح للتطبيق بالوصول.');
    }
  }

  Widget _buildImagePreview() {
    final pickedBytes = _pickedImageBytes;
    final currentUrl = _currentImageUrl?.trim();

    final Widget image;

    if (pickedBytes != null) {
      image = Image.memory(pickedBytes, fit: BoxFit.cover);
    } else if (currentUrl != null && currentUrl.isNotEmpty) {
      image = Image.network(
        currentUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _imagePlaceholder(),
      );
    } else {
      image = _imagePlaceholder();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AspectRatio(aspectRatio: 4 / 3, child: image),
    );
  }

  Widget _imagePlaceholder() {
    return ColoredBox(
      color: Colors.grey.shade200,
      child: const Center(
        child: Icon(
          Icons.add_photo_alternate_outlined,
          size: 48,
          color: Colors.grey,
        ),
      ),
    );
  }

  String? _validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال السعر.';
    }

    final price = double.tryParse(value.trim());

    if (price == null || !price.isFinite || price <= 0) {
      return 'أدخل سعرًا صحيحًا أكبر من صفر.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.initialProduct == null
                  ? 'بيانات المنتج الجديد'
                  : 'تعديل بيانات المنتج',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'أدخل بيانات المنتج التي ستظهر للمشترين.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),

            TextFormField(
              controller: _nameController,
              enabled: !widget.isSubmitting,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'اسم المنتج *',
                hintText: 'مثال: معمول بالتمر',
                prefixIcon: Icon(Icons.inventory_2_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'يرجى إدخال اسم المنتج.';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _priceController,
              enabled: !widget.isSubmitting,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'السعر بالريال السعودي *',
                hintText: 'مثال: 25.00',
                prefixIcon: Icon(Icons.payments_outlined),
                border: OutlineInputBorder(),
              ),
              validator: _validatePrice,
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _descriptionController,
              enabled: !widget.isSubmitting,
              minLines: 3,
              maxLines: 5,
              textInputAction: TextInputAction.newline,
              decoration: const InputDecoration(
                labelText: 'الوصف (اختياري)',
                hintText: 'اكتب وصفًا مختصرًا للمنتج.',
                prefixIcon: Icon(Icons.description_outlined),
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            _buildImagePreview(),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: widget.isSubmitting
                        ? null
                        : () => _pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library_outlined),
                    label: const Text('من المعرض'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: widget.isSubmitting
                        ? null
                        : () => _pickImage(ImageSource.camera),
                    icon: const Icon(Icons.photo_camera_outlined),
                    label: const Text('التقاط صورة'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            FilledButton.icon(
              onPressed: widget.isSubmitting ? null : _submit,
              icon: widget.isSubmitting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.save_outlined),
              label: Text(
                widget.isSubmitting
                    ? 'جارٍ الحفظ...'
                    : widget.initialProduct == null
                    ? 'إضافة المنتج'
                    : 'حفظ التعديلات',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
