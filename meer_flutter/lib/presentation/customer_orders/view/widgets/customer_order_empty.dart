import 'package:flutter/material.dart';

class CustomerOrderEmpty extends StatelessWidget {
  const CustomerOrderEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'لا توجد طلبات حتى الآن.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'ستظهر طلباتك هنا بعد إتمام عملية الشراء.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
