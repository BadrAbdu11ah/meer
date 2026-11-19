import 'package:flutter/material.dart';
import 'package:meer_flutter/presentation/shared/widgets/app_page_header.dart';

class CheckoutEmptyCartView extends StatelessWidget {
  const CheckoutEmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppPageHeader(
            title: 'إتمام الطلب',
            subtitle: 'لا توجد منتجات لإتمام الطلب',
            showBackButton: Navigator.of(context).canPop(),
            onBack: () => Navigator.of(context).maybePop(),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 64,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  const Text('السلة فارغة.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
