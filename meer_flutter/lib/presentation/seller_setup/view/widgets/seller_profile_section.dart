import 'package:flutter/material.dart';

import 'seller_setup_section.dart';

class SellerProfileSection extends StatelessWidget {
  final TextEditingController storeNameController;
  final TextEditingController descriptionController;
  final bool isSubmitting;

  const SellerProfileSection({
    super.key,
    required this.storeNameController,
    required this.descriptionController,
    required this.isSubmitting,
  });

  String? _validateStoreName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'اسم الأسرة مطلوب.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SellerSetupSection(
      icon: Icons.storefront_outlined,
      title: 'بيانات الأسرة',
      description: 'أخبر العملاء عن أسرتك والمنتجات التي تقدمها.',
      child: Column(
        children: [
          TextFormField(
            controller: storeNameController,
            enabled: !isSubmitting,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'اسم الأسرة أو المتجر',
              hintText: 'مثال: أكلات أسرة مِيْر',
              prefixIcon: Icon(Icons.store_outlined),
              border: OutlineInputBorder(),
            ),
            validator: _validateStoreName,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: descriptionController,
            enabled: !isSubmitting,
            maxLines: 3,
            maxLength: 300,
            decoration: const InputDecoration(
              labelText: 'نبذة عن الأسرة (اختياري)',
              hintText: 'ما الأطعمة التي تقدمها أسرتك؟',
              prefixIcon: Icon(Icons.description_outlined),
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
