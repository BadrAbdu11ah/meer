import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';

typedef ProductFormSubmitCallback =
    void Function({
      required String name,
      required String price,
      String? description,
      String? imageUrl,
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
  final _imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final product = widget.initialProduct;

    if (product != null) {
      _nameController.text = product.name;
      _descriptionController.text = product.description ?? '';
      _priceController.text = product.price.toString();
      _imageUrlController.text = product.imageUrl ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _submit() {
    if (widget.isSubmitting) return;

    if (!_formKey.currentState!.validate()) return;

    widget.onSubmit(
      name: _nameController.text,
      price: _priceController.text,
      description: _descriptionController.text,
      imageUrl: _imageUrlController.text,
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

  String? _validateImageUrl(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) return null;

    final uri = Uri.tryParse(text);

    if (uri == null ||
        !uri.hasAuthority ||
        uri.host.isEmpty ||
        !(uri.scheme == 'http' || uri.scheme == 'https')) {
      return 'أدخل رابط صورة يبدأ بـ https:// أو http://';
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

            TextFormField(
              controller: _imageUrlController,
              enabled: !widget.isSubmitting,
              keyboardType: TextInputType.url,
              textInputAction: TextInputAction.done,
              autocorrect: false,
              decoration: const InputDecoration(
                labelText: 'رابط صورة المنتج (اختياري)',
                hintText: 'https://example.com/image.jpg',
                prefixIcon: Icon(Icons.image_outlined),
                border: OutlineInputBorder(),
              ),
              validator: _validateImageUrl,
              onFieldSubmitted: (_) => _submit(),
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
