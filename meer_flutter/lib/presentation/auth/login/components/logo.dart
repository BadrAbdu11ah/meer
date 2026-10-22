import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String title;
  final ColorScheme colors;
  const Logo({super.key, required this.title, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 52,
        fontWeight: FontWeight.bold,
        color: colors.primary,
        letterSpacing: 2,
      ),
      textAlign: TextAlign.center,
    );
  }
}
