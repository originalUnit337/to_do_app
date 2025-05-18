import 'package:flutter/material.dart';
import 'package:to_do_app/presentation/ui_kit/font/font_style.dart';

class AppFontStyle implements FontStyle {
  @override
  TextStyle get body => const TextStyle(fontSize: 16, height: 20 / 16);

  @override
  TextStyle get button => const TextStyle(fontSize: 14, height: 24 / 14);

  @override
  TextStyle get largeTitle => const TextStyle(
    fontSize: 32,
    height: 38 / 32,
    fontWeight: FontWeight.w500,
  );

  @override
  TextStyle get subhead => const TextStyle(fontSize: 14, height: 20 / 14);

  @override
  TextStyle get title => const TextStyle(fontSize: 20, height: 32 / 20);
}
