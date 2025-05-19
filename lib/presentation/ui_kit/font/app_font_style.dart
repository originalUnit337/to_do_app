import 'package:flutter/material.dart';

class AppFontStyle {
  static TextStyle get body => const TextStyle(fontSize: 16, height: 20 / 16);
  static TextStyle get button => const TextStyle(fontSize: 14, height: 24 / 14);
  static TextStyle get largeTitle => const TextStyle(
    fontSize: 32,
    height: 38 / 32,
    fontWeight: FontWeight.w500,
  );
  static TextStyle get subhead =>
      const TextStyle(fontSize: 14, height: 20 / 14);
  static TextStyle get title => const TextStyle(fontSize: 20, height: 32 / 20);
}
