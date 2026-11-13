import 'package:flutter/material.dart';

class CheckoutFailureView extends StatelessWidget {
  final String message;
  final VoidCallback onBack;

  const CheckoutFailureView({
    super.key,
    required this.message,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إتمام الطلب'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 56,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: onBack,
                child: const Text('العودة'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
