import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_flutter/presentation/cart/bloc/cart_bloc.dart';
import 'package:meer_flutter/presentation/cart/view/widgets/cart_item_card.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 72,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'سلتك فارغة',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'استكشف المنتجات وأضف ما يعجبك إلى السلة.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          );
        }

        final bloc = context.read<CartBloc>();

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: state.items.length,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final item = state.items[index];
            final productId = item.product.id;

            if (productId == null) {
              return CartItemCard(
                item: item,
                onIncrease: () {},
                onDecrease: () {},
                onRemove: () {},
              );
            }

            return CartItemCard(
              item: item,
              onIncrease: () {
                bloc.add(
                  CartEvent.quantityIncreased(
                    productId: productId,
                  ),
                );
              },
              onDecrease: () {
                bloc.add(
                  CartEvent.quantityDecreased(
                    productId: productId,
                  ),
                );
              },
              onRemove: () {
                bloc.add(
                  CartEvent.productRemoved(
                    productId: productId,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
