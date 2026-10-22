import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  final String title;
  final ColorScheme colors;

  const Description({super.key, required this.colors, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      'سوق الأسر المنتجة والمناديب',
      style: TextStyle(
        fontSize: 16,
        color: colors.onSurfaceVariant,
      ),
      textAlign: TextAlign.center,
    );
  }
}
