import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:to_do_app/presentation/ui_kit/palette/app_palette.dart';
import 'package:to_do_app/presentation/ui_kit/palette/palette.dart';

class ImportanceDropdown extends StatefulWidget {
  final ValueNotifier<String?> selectedImportanceNotifier;
  const ImportanceDropdown({
    required this.selectedImportanceNotifier,
    super.key,
  });

  @override
  State<ImportanceDropdown> createState() => _ImportanceDropdownState();
}

class _ImportanceDropdownState extends State<ImportanceDropdown> {
  String? selectedValue;
  late List<DropdownMenuEntry<String>> dropdownMenuEntries;
  late Palette currentPalette;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    dropdownMenuEntries = [
      DropdownMenuEntry(
        label: AppLocalizations.of(context)?.no ?? 'no',
        value: 'no',
      ),
      DropdownMenuEntry(
        label: AppLocalizations.of(context)?.low ?? 'low',
        value: 'low',
      ),
      DropdownMenuEntry(
        label: AppLocalizations.of(context)?.high ?? 'high',
        value: 'high',
      ),
    ];
    currentPalette = AppPalette.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      onSelected: (value) {
        widget.selectedImportanceNotifier.value = value;
        setState(() {
          selectedValue = value;
        });
      },
      textStyle: TextStyle(
        color:
            selectedValue == dropdownMenuEntries.last.value
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
      initialSelection:
          widget.selectedImportanceNotifier.value ??
          dropdownMenuEntries.first.value,
      dropdownMenuEntries:
          dropdownMenuEntries.map((e) {
            return DropdownMenuEntry(
              value: e.value,
              label: e.label,
              style: ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(
                  e.value == dropdownMenuEntries.last.value
                      ? currentPalette.colorRed
                      : Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            );
          }).toList(),
    );
  }
}
