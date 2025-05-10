import 'package:flutter/material.dart';
import 'package:to_do_app/presentation/ui_kit/palette/palette.dart';

class PaletteProvider extends InheritedWidget {
  final Palette palette;

  const PaletteProvider({required this.palette, required super.child, super.key});

    static PaletteProvider? of(BuildContext context) {
      return context.dependOnInheritedWidgetOfExactType<PaletteProvider>();
    }

    @override
    bool updateShouldNotify(PaletteProvider oldWidget) {
      return oldWidget.palette != palette;
    }
}
