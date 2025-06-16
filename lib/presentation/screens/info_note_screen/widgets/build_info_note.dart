import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/domain/entities/note.dart';
import 'package:to_do_app/presentation/screens/info_note_screen/bloc/info_note_screen_bloc.dart';
import 'package:to_do_app/presentation/screens/info_note_screen/bloc/info_note_screen_event.dart';
import 'package:to_do_app/presentation/screens/info_note_screen/bloc/info_note_screen_state.dart';
import 'package:to_do_app/presentation/ui_kit/font/app_font_style.dart';
import 'package:to_do_app/presentation/ui_kit/palette/app_palette.dart';
import 'package:to_do_app/presentation/widgets/importance_dropdown.dart';
import 'package:to_do_app/presentation/widgets/switch_data_picker.dart';

class BuildInfoNote extends StatelessWidget {
  final TextEditingController textNoteController;
  final ValueNotifier<String?> selectedImportanceNotifier;
  final ValueNotifier<DateTime?> selectedDateNotifier;
  NoteEntity? note;

  BuildInfoNote({
    required this.textNoteController,
    this.note,
    ValueNotifier<DateTime?>? selectedDateNotifier,
    ValueNotifier<String?>? selectedImportanceNotifier,
    super.key,
  }) : selectedDateNotifier =
           selectedDateNotifier ??
           ValueNotifier<DateTime?>(DateTime.tryParse(note?.makeBefore ?? '')),
       selectedImportanceNotifier =
           selectedImportanceNotifier ??
           ValueNotifier<String?>(note?.importance);

  @override
  Widget build(BuildContext context) {
    final currentPalette = AppPalette.of(context);
    return BlocListener<InfoNoteScreenBloc, InfoNoteScreenState>(
      listener: (context, state) {
        if (state is InfoNoteLoaded) {
          if (state.isUpdated) {
            final snackBar = SnackBar(
              //TODO Add localization
              content: Text(
                state.isUpdated
                    ? 'Successfully updated'
                    : 'Something went wrong',
              ),
              duration: const Duration(seconds: 2),
              action: SnackBarAction(label: 'Close', onPressed: () {}),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => context.pop(note),
            icon: const Icon(Icons.close),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (note != null) {
                  note = NoteEntity(
                    id: note!.id,
                    importance: selectedImportanceNotifier.value ?? '',
                    makeBefore: selectedDateNotifier.value?.toIso8601String(),
                    textNote: textNoteController.text,
                    isCompleted: note!.isCompleted,
                  );
                  context.read<InfoNoteScreenBloc>().add(
                    SaveNoteEvent(
                      NoteEntity(
                        id: note!.id,
                        importance: selectedImportanceNotifier.value ?? '',
                        makeBefore:
                            selectedDateNotifier.value?.toIso8601String(),
                        textNote: textNoteController.text,
                        isCompleted: note!.isCompleted,
                      ),
                    ),
                  );
                }
              },
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
                      BoxShadow(
                        color: Colors.black.withAlpha(6),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: textNoteController,
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
                ImportanceDropdown(
                  selectedImportanceNotifier: selectedImportanceNotifier,
                ),
                const Divider(),
                SwitchDataPicker(selectedDateNotifier: selectedDateNotifier),
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
      ),
    );
  }
}
