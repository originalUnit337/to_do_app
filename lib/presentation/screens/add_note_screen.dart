import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:to_do_app/navigation/app_router.dart';
import 'package:to_do_app/presentation/theme/app_theme.dart';
import 'package:to_do_app/presentation/ui_kit/font/app_font_style.dart';
import 'package:to_do_app/presentation/ui_kit/palette/palette_provider.dart';

class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _dropdownMenuEntries = <String>[
      AppLocalizations.of(context)!.no,
      AppLocalizations.of(context)!.low,
      AppLocalizations.of(context)!.high,
    ];
    final currentPalette = PaletteProvider.of(context)!.palette;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: AppRouter.router.pop,
          icon: const Icon(Icons.close),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              AppLocalizations.of(context)!.save,
              style: AppFontStyle.title.copyWith(
                color: currentPalette.colorBlue,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(12),
                    blurRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                  BoxShadow(color: Colors.black.withAlpha(6), blurRadius: 2),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: AppLocalizations.of(context)!.what_should_i_do,
                  hintStyle: AppFontStyle.title.copyWith(color: currentPalette.labelTertiary),
                  fillColor: Colors.white,
                  filled: true,
                ),
                minLines: 4,
                maxLines: 6,
              ),
            ),
            SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.importance,
              style: AppFontStyle.title,
            ),
            DropdownMenu(
              menuStyle: MenuStyle(),
              initialSelection: _dropdownMenuEntries.first,
              dropdownMenuEntries:
                  _dropdownMenuEntries.map((e) {
                    return DropdownMenuEntry(value: e, label: e);
                  }).toList(),
            ),
            Divider(),
            // TODO: switch + data picker
            Divider(),
            ElevatedButton.icon(
              onPressed: () {},
              label: Text(AppLocalizations.of(context)!.delete),
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
