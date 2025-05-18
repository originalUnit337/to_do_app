import 'package:flutter/material.dart';
import 'package:to_do_app/core/common/helpers/extensions/build_context_ext.dart';
import 'package:to_do_app/presentation/ui_kit/palette/dark.dart';
import 'package:to_do_app/presentation/ui_kit/palette/light.dart';
import 'package:to_do_app/presentation/ui_kit/palette/palette.dart';

class AppPalette {
  static LightPalette get lightPalette => LightPalette();
  static DarkPalette get darkPalette => DarkPalette();
  static Palette of(BuildContext context) {
    return context.isDarkMode ? darkPalette : lightPalette;
  }

  // ? или просто сделать
  // ? return context.isDarkMode DarkPalette() : LightPalette();
}
