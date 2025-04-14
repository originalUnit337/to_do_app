import 'package:flutter/material.dart';
import 'package:to_do_app/presentation/ui%20kit/pallete/dark.dart';
import 'package:to_do_app/presentation/ui%20kit/pallete/light.dart';

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
        //backgroundColor: const Color.fromARGB(255, 0, 122, 255),
        backgroundColor: palette.backElevated,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      appBarTheme: AppBarTheme(backgroundColor: palette.backPrimary),
      iconTheme: IconThemeData(
        color: palette.supportSeparator,
      ), //colorScheme: ColorScheme.fromSeed(),
      listTileTheme: ListTileThemeData(tileColor: palette.backSecondary),
      checkboxTheme: CheckboxThemeData(
        // fillColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        //   const Set<WidgetState> interactiveStates = <WidgetState>{
        //     WidgetState.pressed,
        //     WidgetState.hovered,
        //     WidgetState.focused,
        //   };
        //   if (states.contains(WidgetState.pressed)) {
        //     return palette.colorGreen;
        //   }
        // }),
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
        //backgroundColor: const Color.fromARGB(255, 0, 122, 255),
        backgroundColor: palette.backElevated,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      appBarTheme: AppBarTheme(backgroundColor: palette.backPrimary),
      iconTheme: IconThemeData(
        color: palette.supportSeparator,
      ), //colorScheme: ColorScheme.fromSeed(),
      listTileTheme: ListTileThemeData(tileColor: palette.backSecondary),
      checkboxTheme: CheckboxThemeData(
        // fillColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        //   const Set<WidgetState> interactiveStates = <WidgetState>{
        //     WidgetState.pressed,
        //     WidgetState.hovered,
        //     WidgetState.focused,
        //   };
        //   if (states.contains(WidgetState.pressed)) {
        //     return palette.colorGreen;
        //   }
        // }),
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
