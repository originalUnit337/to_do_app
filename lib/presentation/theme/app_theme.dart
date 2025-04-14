import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get appTheme {
    return ThemeData(
      textTheme: const TextTheme(
        // Large title
        titleLarge: TextStyle(fontSize: 32, height: 38 / 32),
        // Title
        titleMedium: TextStyle(fontSize: 20),
        // Button
        titleSmall: TextStyle(fontSize: 14),
        // Body
        bodyLarge: TextStyle(fontSize: 16),
        // Subhead
        bodyMedium: TextStyle(fontSize: 14),
      ),
      scaffoldBackgroundColor: const Color.fromARGB(255, 247, 246, 242),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        //backgroundColor: const Color.fromARGB(255, 0, 122, 255),
        backgroundColor: Color(0xFF007AFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      iconTheme: const IconThemeData(
        color: Color.fromARGB(255, 255, 0, 0),
      ), //colorScheme: ColorScheme.fromSeed(),
    );
  }
}
