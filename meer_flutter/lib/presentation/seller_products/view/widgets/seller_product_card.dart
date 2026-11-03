import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/core/constant/app_route.dart';
import 'package:meer_flutter/presentation/seller_products/view/widgets/confirm_delete_product_dialog.dart';
import 'package:meer_flutter/presentation/seller_products/view/widgets/seller_product_image.dart';

enum _ProductAction {
  edit,
  delete,
}

class SellerProductCard extends StatelessWidget {
  final Product product;
  final ThemeData theme;
  final ColorScheme colors;
  final bool isUpdating;
  final void Function(int, bool) onAvailabilityChanged;
  final void Function(Product) onEdit;
  final ValueChanged<int> onDeleteRequested;

  const SellerProductCard({
    super.key,
    required this.product,
    required this.theme,
    required this.colors,
    required this.isUpdating,
    required this.onAvailabilityChanged,
    required this.onEdit,
    required this.onDeleteRequested,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SellerProductImage(product: product),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    product.description?.trim().isNotEmpty == true
                        ? product.description!.trim()
                        : 'لا يوجد وصف للمنتج.',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${product.price.toStringAsFixed(2)} ر.س',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.isAvailable ? 'متاح للبيع' : 'متوقف مؤقتًا',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: product.isAvailable
                                ? colors.primary
                                : colors.error,
                          ),
                        ),
                      ),
                      if (isUpdating)
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      else
                        Switch(
                          value: product.isAvailable,
                          onChanged: product.id == null
                              ? null
                              : (value) {
                                  onAvailabilityChanged(
                                    product.id!,
                                    value,
                                  );
                                },
                        ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pushNamed(
                      AppRoute.sellerDetailsScreen,
                      arguments: product.sellerId,
                    ),
                    child: Text("تفاصيل الأسرة المنتجة"),
                  ),
                ],
              ),
            ),
            PopupMenuButton<_ProductAction>(
              enabled: !isUpdating && product.id != null,
              tooltip: 'إجراءات المنتج',
              onSelected: (action) {
                switch (action) {
                  case _ProductAction.edit:
                    onEdit(product);
                  case _ProductAction.delete:
                    confirmDelete(context, product, onDeleteRequested);
                }
              },
              itemBuilder: (_) => const [
                PopupMenuItem(
                  value: _ProductAction.edit,
                  child: Row(
                    children: [
                      Icon(Icons.edit_outlined),
                      SizedBox(width: 8),
                      Text('تعديل المنتج'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: _ProductAction.delete,
                  child: Row(
                    children: [
                      Icon(Icons.delete_outline, color: Colors.red),
                      SizedBox(width: 8),
                      Text('حذف المنتج'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
