import 'package:flutter/material.dart';

extension ColorExt on Color {
  static Color fromHex(String hexColor) {
    return Color(int.parse(hexColor.replaceFirst('#', '0xFF')));
  }
}
