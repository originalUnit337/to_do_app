import 'package:flutter/material.dart';

abstract interface class Palette {
  // Support
  Color get supportSeparator => const Color(0x33000000);
  Color get supportOverlay => const Color(0x0F000000);
  // Label
  Color get labelPrimary => const Color(0xFF000000);
  Color get labelSecondary => const Color(0x99000000);
  Color get labelTertiary => const Color(0x4D000000);
  Color get labelDisable => const Color(0x26000000);
  // Color
  Color get colorRed => const Color(0xFFFF3B30);
  Color get colorGreen => const Color(0xFF34C759);
  Color get colorBlue => const Color(0xFF007AFF);
  Color get colorGray => const Color(0xFF8E8E93);
  Color get colorGrayLight => const Color(0xFFD1D1D6);
  Color get colorWhite => const Color(0xFFFFFFFF);
  // Back
  Color get backPrimary => const Color(0xFFF7F6F2);
  Color get backSecondary => const Color(0xFFFFFFFF);
  Color get backElevated => const Color(0xFFFFFFFF);
}
