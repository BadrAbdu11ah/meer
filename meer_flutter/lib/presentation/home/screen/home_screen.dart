import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/core/constant/city_info.dart';
import 'package:meer_flutter/presentation/home/bloc/home_bloc.dart';
import 'package:meer_flutter/presentation/home/view/widgets/home_error.dart';
import 'package:meer_flutter/presentation/home/view/home_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // تحديث المنتجات بالسحب إلى الأسفل.
  Future<void> refreshProducts() async {
    final bloc = context.read<HomeBloc>();

    final completed = bloc.stream.firstWhere(
      (state) => state.maybeWhen(
        productsLoaded: (_) => true,
        error: (_) => true,
        orElse: () => false,
      ),
    );

    bloc.add(const HomeProductsRequested());

    await completed;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'مِيْر',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, _) {
              final bloc = context.read<HomeBloc>();

              return PopupMenuButton<MeerCity>(
                tooltip: 'تغيير المدينة',
                initialValue: bloc.city,
                onSelected: (city) => bloc.add(HomeCityChanged(city)),
                itemBuilder: (_) => [
                  for (final city in MeerCity.values)
                    PopupMenuItem(value: city, child: Text(city.label)),
                ],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_on_outlined, size: 20),
                      const SizedBox(width: 4),
                      Text(bloc.city.label),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    message,
                    style: TextStyle(
                      color: colors.onErrorContainer,
                    ),
                  ),
                  backgroundColor: colors.errorContainer,
                  duration: const Duration(seconds: 4),
                ),
              );
            },
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            productsLoaded: (products) {
              return HomeView(
                refreshProducts: refreshProducts,
                theme: theme,
                colors: colors,
                products: products,
              );
            },
            error: (message) {
              return HomeError(
                colors: colors,
                message: message,
              );
            },
            orElse: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
