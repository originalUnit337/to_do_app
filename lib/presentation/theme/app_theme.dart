import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get appTheme {
    return ThemeData(
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 32),
        titleMedium: TextStyle(fontSize: 20),
        titleSmall: TextStyle(fontSize: 14),
        bodyLarge: TextStyle(fontSize: 16),
        bodyMedium: TextStyle(fontSize: 14),
      ),
      scaffoldBackgroundColor: const Color.fromARGB(255, 247, 246, 242),
      //colorScheme: ColorScheme.fromSeed(),
    );
  }
}
