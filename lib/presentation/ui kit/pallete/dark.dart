import 'dart:ui';

import 'package:to_do_app/presentation/ui%20kit/pallete/palette.dart';

class DarkPalette implements Palette {
  @override
  Color get backElevated => const Color(0xFF3C3C3F);

  @override
  Color get backPrimary => const Color(0xFF161618);

  @override
  Color get backSecondary => const Color(0xFF252528);

  @override
  Color get colorBlue => const Color(0xFF0A84FF);

  @override
  Color get colorGray => const Color(0xFF8E8E93);

  @override
  Color get colorGrayLight => const Color(0xFF48484A);

  @override
  Color get colorGreen => const Color(0xFF32D74B);

  @override
  Color get colorRed => const Color(0xFFFF453A);

  @override
  Color get colorWhite => const Color(0xFFFFFFFF);

  @override
  Color get labelDisable => const Color(0x26FFFFFF);

  @override
  Color get labelPrimary => const Color(0xFFFFFFFF);

  @override
  Color get labelSecondary => const Color(0x99FFFFFF);

  @override
  Color get labelTertiary => const Color(0x66FFFFFF);

  @override
  Color get supportOverlay => const Color(0x52000000);

  @override
  Color get supportSeparator => const Color(0x33FFFFFF);
}
