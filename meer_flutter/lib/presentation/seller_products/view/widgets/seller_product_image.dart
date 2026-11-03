import 'package:flutter/material.dart';
import 'package:meer_client/meer_client.dart';

class SellerProductImage extends StatelessWidget {
  final Product product;
  const SellerProductImage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: 92,
        height: 100,
        child: _buildImage(product.imageUrl),
      ),
    );
  }

  Widget _buildImage(String? imageUrl) {
    if (imageUrl == null || imageUrl.trim().isEmpty) {
      return Container(
        color: Colors.grey.shade200,
        alignment: Alignment.center,
        child: const Icon(
          Icons.restaurant,
          size: 36,
          color: Colors.grey,
        ),
      );
    }

    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) {
        return Container(
          color: Colors.grey.shade200,
          alignment: Alignment.center,
          child: const Icon(
            Icons.image_not_supported_outlined,
            size: 36,
            color: Colors.grey,
          ),
        );
      },
    );
  }
}
