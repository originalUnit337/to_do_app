import 'package:flutter/material.dart';
import 'package:to_do_app/presentation/ui_kit/palette/dark.dart';
import 'package:to_do_app/presentation/ui_kit/palette/light.dart';

class AppTheme {
  static ThemeData get lightAppTheme {
    final palette = LightPalette();
    return ThemeData(
      brightness: Brightness.light,
      primaryColorLight: Colors.white,
      primaryColorDark: Colors.black,
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
      scaffoldBackgroundColor: palette.backPrimary,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: palette.backElevated,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      appBarTheme: AppBarTheme(backgroundColor: palette.backPrimary),
      iconTheme: IconThemeData(
        color: palette.supportSeparator,
      ), //colorScheme: ColorScheme.fromSeed(),
      listTileTheme: ListTileThemeData(tileColor: palette.backSecondary),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.fromMap({
          WidgetState.selected: palette.colorGreen,
          WidgetState.hovered: palette.colorWhite,
          WidgetState.focused: palette.colorGrayLight,
          WidgetState.disabled: palette.colorGrayLight,
        }),
        side: BorderSide(color: palette.supportSeparator, width: 2),
      ),
    );
  }

  static ThemeData get darkAppTheme {
    final palette = DarkPalette();
    return ThemeData(
      brightness: Brightness.dark,
      primaryColorLight: Colors.white,
      primaryColorDark: Colors.black,
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
      scaffoldBackgroundColor: palette.backPrimary,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: palette.backElevated,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      appBarTheme: AppBarTheme(backgroundColor: palette.backPrimary),
      iconTheme: IconThemeData(color: palette.supportSeparator),
      listTileTheme: ListTileThemeData(tileColor: palette.backSecondary),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.fromMap({
          WidgetState.selected: palette.colorGreen,
          WidgetState.hovered: palette.colorWhite,
          WidgetState.focused: palette.colorGrayLight,
          WidgetState.disabled: palette.colorGrayLight,
        }),
        side: BorderSide(color: palette.supportSeparator, width: 2),
      ),
    );
  }
}
