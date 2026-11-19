import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meer_flutter/presentation/seller_details/bloc/seller_details_bloc.dart';
import 'package:meer_flutter/presentation/seller_details/view/seller_details_view.dart';
import 'package:meer_flutter/presentation/shared/widgets/app_page_header.dart';

class SellerDetailsScreen extends StatelessWidget {
  const SellerDetailsScreen({
    super.key,
    required this.sellerId,
  });

  final int sellerId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerDetailsBloc, SellerDetailsState>(
      builder: (context, state) {
        final title = state.maybeWhen(
          loaded: (seller, products) => seller.storeName,
          orElse: () => 'الأسرة المنتجة',
        );

        return Scaffold(
          body: state.when(
            initial: () => Column(
              children: [
                AppPageHeader(
                  title: title,
                  subtitle: 'منتجات ومعلومات الأسرة',
                  showBackButton: Navigator.of(context).canPop(),
                  onBack: () => Navigator.of(context).maybePop(),
                ),
                Expanded(
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (seller, products) => Column(
              children: [
                AppPageHeader(
                  title: "معلومات ومنتجات الأسرة",
                  showBackButton: Navigator.of(context).canPop(),
                  onBack: () => Navigator.of(context).maybePop(),
                ),
                Expanded(
                  child: SellerDetailsView(
                    seller: seller,
                    products: products,
                  ),
                ),
              ],
            ),
            error: (message) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: () {
                        context.read<SellerDetailsBloc>().add(
                          SellerDetailsEvent.loadRequested(
                            sellerId: sellerId,
                          ),
                        );
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
