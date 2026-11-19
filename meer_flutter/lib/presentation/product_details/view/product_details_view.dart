import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({
    super.key,
    required this.product,
    required this.sellerName,
    required this.onSellerTap,
  });

  final Product product;
  final String sellerName;
  final VoidCallback onSellerTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final description = product.description?.trim();
    final displaySellerName = sellerName.trim().isNotEmpty
        ? sellerName.trim()
        : 'أسرة منتجة';

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة المنتج وحالة التوفر.
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 280,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _buildImage(product.imageUrl),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: _buildAvailabilityBadge(
                      context,
                      product.isAvailable,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // بطاقة الأسرة المنتجة.
          _buildSellerCard(
            context,
            displaySellerName,
          ),

          const SizedBox(height: 24),

          // اسم المنتج والسعر.
          Text(
            product.name,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 14),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: colors.primaryContainer.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.sell_outlined,
                  color: colors.primary,
                ),
                const SizedBox(width: 10),
                Text(
                  'السعر',
                  style: theme.textTheme.titleMedium,
                ),
                const Spacer(),
                Text(
                  '${product.price.toStringAsFixed(2)} ر.س',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // وصف المنتج.
          Row(
            children: [
              Icon(
                Icons.notes_outlined,
                color: colors.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'وصف المنتج',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.surfaceContainerHighest.withValues(
                alpha: 0.45,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              description == null || description.isEmpty
                  ? 'لا يوجد وصف لهذا المنتج حاليًا.'
                  : description,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.8,
                color: colors.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSellerCard(
    BuildContext context,
    String displayName,
  ) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return InkWell(
      onTap: onSellerTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colors.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: colors.outlineVariant,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: colors.primaryContainer,
              child: Icon(
                Icons.storefront_outlined,
                color: colors.onPrimaryContainer,
                size: 25,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الأسرة المنتجة',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    displayName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.arrow_forward_ios,
              size: 13,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailabilityBadge(
    BuildContext context,
    bool isAvailable,
  ) {
    final colors = Theme.of(context).colorScheme;

    final background = isAvailable
        ? Colors.green.withValues(alpha: 0.9)
        : colors.error;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isAvailable ? Icons.check_circle_outline : Icons.block_outlined,
            size: 16,
            color: Colors.white,
          ),
          const SizedBox(width: 6),
          Text(
            isAvailable ? 'متاح للبيع' : 'غير متاح',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String? imageUrl) {
    final url = imageUrl?.trim();

    if (url == null || url.isEmpty) {
      return const _ProductImagePlaceholder();
    }

    return Image.network(
      url,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => const _ProductImagePlaceholder(),
    );
  }
}

class _ProductImagePlaceholder extends StatelessWidget {
  const _ProductImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey.shade200,
      child: const Center(
        child: Icon(
          Icons.restaurant,
          size: 64,
          color: Colors.grey,
        ),
      ),
    );
  }
}
