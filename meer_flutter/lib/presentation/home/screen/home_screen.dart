import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_client/meer_client.dart';
import 'package:meer_flutter/core/constant/city_info.dart';
import 'package:meer_flutter/presentation/home/bloc/home_bloc.dart';
import 'package:meer_flutter/presentation/home/view/home_view.dart';
import 'package:meer_flutter/presentation/home/view/widgets/home_error.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// تحديث المنتجات بالسحب إلى الأسفل.
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
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _HomeHeader(),

            Expanded(
              child: BlocConsumer<HomeBloc, HomeState>(
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
            ),
          ],
        ),
      ),
    );
  }
}

/// رأس الصفحة الرئيسية.
class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final bloc = context.read<HomeBloc>();

        return Container(
          decoration: BoxDecoration(
            color: colors.primaryFixedDim,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          child: Row(
            children: [
              // هوية مِيْر.
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  Icons.storefront_rounded,
                  color: colors.onPrimaryContainer,
                  size: 27,
                ),
              ),

              const SizedBox(width: 11),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'مِيْــــر',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                        color: colors.primary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'سوق الأسر المنتجة',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              // اختيار المدينة.
              PopupMenuButton<MeerCity>(
                tooltip: 'تغيير المدينة',
                initialValue: bloc.city,
                onSelected: (city) {
                  bloc.add(HomeCityChanged(city));
                },
                itemBuilder: (_) => [
                  for (final city in MeerCity.values)
                    PopupMenuItem(
                      value: city,
                      child: Text(city.label),
                    ),
                ],
                child: Container(
                  constraints: const BoxConstraints(
                    minHeight: 44,
                    maxWidth: 150,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(
                      color: colors.outlineVariant,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 18,
                        color: colors.primary,
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          bloc.city.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 3),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 20,
                        color: colors.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
