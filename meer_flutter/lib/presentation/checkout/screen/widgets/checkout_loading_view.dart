import 'package:flutter/material.dart';
import 'package:meer_flutter/presentation/shared/widgets/app_page_header.dart';

class CheckoutLoadingView extends StatelessWidget {
  const CheckoutLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppPageHeader(
            title: 'إتمام الطلب',
            subtitle: 'جارٍ تجهيز بيانات طلبك',
            showBackButton: Navigator.of(context).canPop(),
            onBack: () => Navigator.of(context).maybePop(),
          ),
          const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
