import 'package:flutter/material.dart';

class CheckoutLoadingView extends StatelessWidget {
  const CheckoutLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إتمام الطلب'),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
