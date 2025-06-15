import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/domain/entities/note.dart';
import 'package:to_do_app/injection_container.dart';
import 'package:to_do_app/presentation/screens/info_note_screen/bloc/info_note_screen_bloc.dart';
import 'package:to_do_app/presentation/screens/info_note_screen/bloc/info_note_screen_event.dart';
import 'package:to_do_app/presentation/screens/info_note_screen/bloc/info_note_screen_state.dart';
import 'package:to_do_app/presentation/screens/info_note_screen/widgets/build_info_note.dart';
import 'package:to_do_app/presentation/ui_kit/font/app_font_style.dart';
import 'package:to_do_app/presentation/ui_kit/palette/app_palette.dart';

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
    return BlocProvider<InfoNoteScreenBloc>(
      create: (context) => InfoNoteScreenBloc(getIt()),
      child: BlocBuilder<InfoNoteScreenBloc, InfoNoteScreenState>(
        builder: (context, state) {
          return switch (state) {
            InfoNoteInitial() => BuildInfoNote(
              note: widget.note,
              textNoteController: _textNoteController,
            ),
            InfoNoteLoading() => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
            InfoNoteLoaded() => BuildInfoNote(
              note: state.note,
              textNoteController: _textNoteController,
            ),
            InfoNoteError() => Scaffold(
              body: Center(child: Text(state.exception.toString())),
            ),
          };
        },
      ),
    );
  }
}
