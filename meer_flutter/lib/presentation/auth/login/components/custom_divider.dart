import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final ColorScheme colors;

  const CustomDivider({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: colors.outlineVariant)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'أو',
            style: TextStyle(
              color: colors.onSurfaceVariant,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(child: Divider(color: colors.outlineVariant)),
      ],
    );
  }
}
