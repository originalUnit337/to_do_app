import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:to_do_app/presentation/ui_kit/palette/app_palette.dart';

class ImportanceDropdown extends StatefulWidget {
  const ImportanceDropdown({super.key});

  @override
  State<ImportanceDropdown> createState() => _ImportanceDropdownState();
}

class _ImportanceDropdownState extends State<ImportanceDropdown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final dropdownMenuEntries = <String>[
      AppLocalizations.of(context)?.no ?? 'no',
      AppLocalizations.of(context)?.low ?? 'low',
      AppLocalizations.of(context)?.high ?? 'high',
    ];
    final currentPalette = AppPalette.of(context);
    return DropdownMenu(
      onSelected: (value) {
        setState(() {
          selectedValue = value;
        });
      },
      textStyle: TextStyle(
        color:
            selectedValue == dropdownMenuEntries.last
                ? currentPalette.colorRed
                : Theme.of(context).textTheme.bodyMedium?.color,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(currentPalette.backElevated),
        alignment: Alignment.topLeft,
      ),
      initialSelection: dropdownMenuEntries.first,
      dropdownMenuEntries:
          dropdownMenuEntries.map((e) {
            return DropdownMenuEntry(
              value: e,
              label: e,
              style: ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(
                  e == dropdownMenuEntries.last
                      ? currentPalette.colorRed
                      : Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            );
          }).toList(),
    );
  }
}
