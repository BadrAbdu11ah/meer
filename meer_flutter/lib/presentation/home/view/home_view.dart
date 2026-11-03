import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/core/constant/app_route.dart';
import 'package:meer_flutter/presentation/favorites/bloc/favorites_bloc.dart';
import 'package:meer_flutter/presentation/shared/widgets/product_card.dart';
import 'package:meer_flutter/presentation/search/bloc/search_bloc.dart';
import 'package:meer_flutter/presentation/search/view/custom_search_delegate.dart';

class HomeView extends StatelessWidget {
  final Future<void> Function() refreshProducts;
  final ThemeData theme;
  final ColorScheme colors;
  final List<Product> products;

  const HomeView({
    super.key,
    required this.refreshProducts,
    required this.theme,
    required this.colors,
    required this.products,
  });

  // فتح شاشة البحث المستقلة.
  void _openSearch(BuildContext context) {
    final searchBloc = context.read<SearchBloc>();

    searchBloc.add(
      const SearchEvent.clearSearch(),
    );

    showSearch(
      context: context,
      delegate: CustomSearchDelegate(
        searchBloc: searchBloc,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshProducts,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'اكتشف الأطعمة المنزلية',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'تصفح المنتجات المتاحة من الأسر المنتجة.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),

          // حقل للقراءة فقط يفتح شاشة البحث.
          TextFormField(
            readOnly: true,
            onTap: () => _openSearch(context),
            decoration: InputDecoration(
              hintText: 'ابحث عن طبق أو منتج...',
              hintStyle: const TextStyle(fontSize: 16),
              prefixIcon: IconButton(
                tooltip: 'البحث',
                onPressed: () => _openSearch(context),
                icon: Icon(
                  Icons.search_outlined,
                  color: colors.onSurfaceVariant,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: colors.surfaceContainerHighest,
            ),
          ),

          const SizedBox(height: 24),

          Text(
            'المنتجات المتاحة',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          if (products.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 48,
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.restaurant_menu,
                    size: 48,
                    color: colors.onSurfaceVariant,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'لا توجد منتجات متاحة حاليًا.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else
            BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, favoritesState) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 240,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.68,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];

                    return ProductCard(
                      product: product,
                      isFavorite: favoritesState.containsProduct(product.id),

                      onFavoriteTap: () {
                        context.read<FavoritesBloc>().add(
                          FavoritesEvent.productToggled(
                            product: product,
                          ),
                        );
                      },

                      onTap: () {
                        Navigator.of(context).pushNamed(
                          AppRoute.productDetailsScreen,
                          arguments: product,
                        );
                      },

                      onSellerTap: () {
                        Navigator.of(context).pushNamed(
                          AppRoute.sellerDetailsScreen,
                          arguments: product.sellerId,
                        );
                      },
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}
