import 'package:flutter/material.dart';

extension TextExtension on BuildContext {
  TitleTheme get title => TitleTheme(
        primary: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
        secondary: TextStyle(
          color: Colors.cyan.shade700,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        navHeader: const TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        navSecondary: TextStyle(
          color: Colors.cyan.shade700,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      );

  BodyTheme get body => const BodyTheme(
        large: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        regular: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        small: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      );
}

class TitleTheme {
  final TextStyle primary;
  final TextStyle secondary;
  final TextStyle navHeader;
  final TextStyle navSecondary;

  const TitleTheme({
    required this.primary,
    required this.secondary,
    required this.navHeader,
    required this.navSecondary,
  });
}

class BodyTheme {
  final TextStyle large;
  final TextStyle regular;
  final TextStyle small;

  const BodyTheme({
    required this.large,
    required this.regular,
    required this.small,
  });
}
