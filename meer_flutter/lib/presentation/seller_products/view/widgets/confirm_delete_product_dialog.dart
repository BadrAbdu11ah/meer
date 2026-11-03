import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';

Future<void> confirmDelete(
  BuildContext context,
  Product product,
  ValueChanged<int> onDeleteRequested,
) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('حذف المنتج'),
      content: Text(
        'هل أنت متأكد من حذف «${product.name}»؟ '
        'لا يمكن التراجع عن هذا الإجراء.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: const Text('إلغاء'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
          onPressed: () => Navigator.pop(dialogContext, true),
          child: const Text('حذف'),
        ),
      ],
    ),
  );

  if (confirmed == true && product.id != null) {
    onDeleteRequested(product.id!);
  }
}
