import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_flutter/core/constant/app_route.dart';

import 'package:meer_flutter/core/id/injection.dart';
import 'package:meer_flutter/presentation/account/bloc/account_bloc.dart';
import 'package:meer_flutter/presentation/account/screen/account_screen.dart';
import 'package:meer_flutter/presentation/cart/bloc/cart_bloc.dart';
import 'package:meer_flutter/presentation/customer_orders/bloc/customer_orders_bloc.dart';
import 'package:meer_flutter/presentation/customer_orders/screen/customer_orders_screen.dart';
import 'package:meer_flutter/presentation/favorites/bloc/favorites_bloc.dart';
import 'package:meer_flutter/presentation/favorites/screen/favorites_screen.dart';
import 'package:meer_flutter/presentation/home/bloc/home_bloc.dart';
import 'package:meer_flutter/presentation/home/screen/home_screen.dart';
import 'package:meer_flutter/presentation/main/bloc/main_bloc.dart';
import 'package:meer_flutter/presentation/main/view/main_bottom_app_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  HomeBloc? _homeBloc;
  // الاحتفاظ بعناصر الصفحات التي أُنشئت بالفعل.
  final Map<int, Widget> _pageCache = {};

  CustomerOrdersBloc? _customerOrdersBloc;

  @override
  void initState() {
    super.initState();

    context.read<CartBloc>().add(
      const CartEvent.loadRequested(),
    );

    context.read<FavoritesBloc>().add(
      const FavoritesEvent.loadRequested(),
    );
  }

  // إنشاء الصفحة عند أول زيارة فقط.
  Widget _createPage(int index) {
    switch (index) {
      case 0:
        return BlocProvider<HomeBloc>(
          key: const ValueKey('main-home-page'),
          create: (_) {
            final bloc = sl<HomeBloc>();
            _homeBloc = bloc;

            bloc.add(const HomeProductsRequested());

            return bloc;
          },
          child: const HomeScreen(),
        );

      case 1:
        return const FavoritesScreen(
          key: ValueKey('favorites-page'),
        );

      case 2:
        return BlocProvider<CustomerOrdersBloc>(
          key: const ValueKey('customer-orders-page'),
          create: (_) {
            final bloc = sl<CustomerOrdersBloc>();
            _customerOrdersBloc = bloc;

            bloc.add(
              const CustomerOrdersEvent.loadRequested(),
            );

            return bloc;
          },
          child: const CustomerOrdersScreen(),
        );

      case 3:
        return BlocProvider<AccountBloc>(
          key: const ValueKey('account-page'),
          create: (_) => sl<AccountBloc>()
            ..add(
              const AccountEvent.loadRequested(),
            ),
          child: const AccountScreen(),
        );

      default:
        return const SizedBox.shrink();
    }
  }

  // إنشاء العناصر التي زارها المستخدم فقط.
  List<Widget> _buildPages(Set<int> visitedPages) {
    return List<Widget>.generate(
      MainBloc.pageCount,
      (index) {
        if (!visitedPages.contains(index)) {
          return SizedBox.shrink(
            key: ValueKey('unvisited-page-$index'),
          );
        }

        // استخدام عنصر الصفحة نفسه بعد أول إنشائه.
        return _pageCache.putIfAbsent(
          index,
          () => _createPage(index),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: BlocBuilder<CartBloc, CartState>(
            builder: (context, cartState) {
              return FloatingActionButton(
                tooltip: 'السلة',
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoute.cartScreen,
                  );
                },
                shape: const CircleBorder(),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    const Icon(Icons.shopping_cart_outlined),

                    if (cartState.totalItems > 0)
                      Positioned(
                        top: -10,
                        right: -12,
                        child: Container(
                          constraints: const BoxConstraints(
                            minWidth: 21,
                            minHeight: 21,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.error,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            cartState.totalItems > 99
                                ? '99+'
                                : '${cartState.totalItems}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onError,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: MainBottomAppBar(
            currentPage: state.currentPage,
            onTap: (index) {
              final mainBloc = context.read<MainBloc>();

              if (index == 0 && mainBloc.state.currentPage != 0) {
                _homeBloc?.add(
                  const HomeProductsRequested(),
                );
              }

              if (index == 2 && mainBloc.state.currentPage != 2) {
                _customerOrdersBloc?.add(
                  const CustomerOrdersEvent.refreshRequested(),
                );
              }

              mainBloc.add(
                MainEvent.pageChanged(index),
              );
            },
          ),
          body: IndexedStack(
            index: state.currentPage,
            children: _buildPages(state.visitedPages),
          ),
        );
      },
    );
  }
}
