import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/core/constant/app_route.dart';
import 'package:meer_flutter/presentation/cart/bloc/cart_bloc.dart';
import 'package:meer_flutter/presentation/product_details/view/product_details_view.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listenWhen: (previous, current) => current.message != null,
      listener: (context, state) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(state.message!),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 2),
            ),
          );

        context.read<CartBloc>().add(
          const CartEvent.messageCleared(),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'تفاصيل المنتج',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
          child: ProductDetailsView(
            product: product,
            onSellerTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoute.sellerDetailsScreen,
                arguments: product.sellerId,
              );
            },
          ),
        ),

        bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
          builder: (context, cartState) {
            final matchingItems = cartState.items.where(
              (item) => item.product.id == product.id,
            );

            final cartItem = matchingItems.isEmpty ? null : matchingItems.first;

            final isAvailable = product.isAvailable;

            return SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (cartItem == null)
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: isAvailable
                              ? () {
                                  context.read<CartBloc>().add(
                                    CartEvent.productAdded(
                                      product: product,
                                    ),
                                  );
                                }
                              : null,
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(54),
                          ),
                          icon: Icon(
                            isAvailable
                                ? Icons.add_shopping_cart
                                : Icons.block_outlined,
                          ),
                          label: Text(
                            isAvailable
                                ? 'أضف إلى السلة'
                                : 'غير متاح للبيع حاليًا',
                          ),
                        ),
                      )
                    else
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton.icon(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  AppRoute.cartScreen,
                                );
                              },
                              style: FilledButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                              ),
                              icon: const Icon(Icons.shopping_bag_outlined),
                              label: const Text('عرض السلة'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(
                                  context,
                                ).colorScheme.outlineVariant,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    context.read<CartBloc>().add(
                                      CartEvent.quantityDecreased(
                                        productId: product.id!,
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.remove),
                                ),
                                Text(
                                  '${cartItem.quantity}',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                IconButton(
                                  onPressed: isAvailable
                                      ? () {
                                          context.read<CartBloc>().add(
                                            CartEvent.quantityIncreased(
                                              productId: product.id!,
                                            ),
                                          );
                                        }
                                      : null,
                                  icon: const Icon(Icons.add),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                    if (!isAvailable && cartItem != null)
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          'هذا المنتج لم يعد متاحًا للبيع. يمكنك إزالة الكمية من السلة.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
