import 'dart:ui';

import 'package:to_do_app/presentation/ui_kit/palette/palette.dart';

class LightPalette implements Palette {
  // Support
  @override
  Color get supportSeparator => const Color(0x33000000);
  @override
  Color get supportOverlay => const Color(0x0F000000);
  // Label
  @override
  Color get labelPrimary => const Color(0xFF000000);
  @override
  Color get labelSecondary => const Color(0x99000000);
  @override
  Color get labelTertiary => const Color(0x4D000000);
  @override
  Color get labelDisable => const Color(0x26000000);
  // Color
  @override
  Color get colorRed => const Color(0xFFFF3B30);
  @override
  Color get colorGreen => const Color(0xFF34C759);
  @override
  Color get colorBlue => const Color(0xFF007AFF);
  @override
  Color get colorGray => const Color(0xFF8E8E93);
  @override
  Color get colorGrayLight => const Color(0xFFD1D1D6);
  @override
  Color get colorWhite => const Color(0xFFFFFFFF);
  // Back
  @override
  Color get backPrimary => const Color(0xFFF7F6F2);
  @override
  Color get backSecondary => const Color(0xFFFFFFFF);
  @override
  Color get backElevated => const Color(0xFFFFFFFF);
}
