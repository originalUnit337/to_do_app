import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/domain/entities/note.dart';
import 'package:to_do_app/presentation/ui_kit/font/app_font_style.dart';
import 'package:to_do_app/presentation/ui_kit/palette/app_palette.dart';
import 'package:to_do_app/presentation/widgets/importance_dropdown.dart';
import 'package:to_do_app/presentation/widgets/switch_data_picker.dart';

class InfoNoteScreen extends StatefulWidget {
  final NoteEntity? note;
  const InfoNoteScreen({this.note, super.key});

  @override
  State<InfoNoteScreen> createState() => _InfoNoteScreenState();
}

class _InfoNoteScreenState extends State<InfoNoteScreen> {
  late TextEditingController _textNoteController;

  @override
  void initState() {
    super.initState();
    _textNoteController = TextEditingController(text: widget.note?.textNote);
  }

  @override
  void dispose() {
    _textNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentPalette = AppPalette.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.close),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              AppLocalizations.of(context)?.save ?? 'Save',
              style: AppFontStyle.title.copyWith(
                color: currentPalette.colorBlue,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 10,
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
                  controller: _textNoteController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: AppLocalizations.of(context)?.what_should_i_do,
                    hintStyle: AppFontStyle.title.copyWith(
                      color: currentPalette.labelTertiary,
                    ),
                    fillColor: currentPalette.backSecondary,
                    filled: true,
                  ),
                  minLines: 4,
                  maxLines: 6,
                ),
              ),
              Text(
                AppLocalizations.of(context)?.importance ?? 'Importance',
                style: AppFontStyle.title,
              ),
              const ImportanceDropdown(),
              const Divider(),
              const SwitchDataPicker(),
              const Divider(),
              ElevatedButton.icon(
                onPressed: () {},
                label: Text(
                  AppLocalizations.of(context)?.delete ?? 'Delete',
                  style: AppFontStyle.body.copyWith(
                    color: currentPalette.colorRed,
                  ),
                ),
                icon: Icon(
                  Icons.delete,
                  size: 24,
                  color: currentPalette.colorRed,
                ),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    currentPalette.backPrimary,
                  ),
                  elevation: const WidgetStatePropertyAll(0),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
