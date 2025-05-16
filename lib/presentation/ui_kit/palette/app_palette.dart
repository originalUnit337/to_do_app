import 'package:flutter/material.dart';
import 'package:to_do_app/presentation/ui_kit/palette/dark.dart';
import 'package:to_do_app/presentation/ui_kit/palette/light.dart';
import 'package:to_do_app/presentation/ui_kit/palette/palette.dart';

class AppPalette {
  static final Palette _lightPalette = LightPalette();
  static final Palette _darkPalette = DarkPalette();
  static Palette of(BuildContext context) {
    return context.isDarkMode ? _darkPalette : _lightPalette;
  }
}

extension on BuildContext {
  bool get isDarkMode {
    return Theme.of(this).brightness == Brightness.dark;
  }
}
