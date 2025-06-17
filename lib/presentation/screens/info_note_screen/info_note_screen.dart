import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/domain/entities/note.dart';
import 'package:to_do_app/injection_container.dart';
import 'package:to_do_app/presentation/screens/info_note_screen/bloc/info_note_screen_bloc.dart';
import 'package:to_do_app/presentation/screens/info_note_screen/bloc/info_note_screen_state.dart';
import 'package:to_do_app/presentation/screens/info_note_screen/widgets/info_note_widget.dart';

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
      create: (context) => InfoNoteScreenBloc(getIt(), getIt(), getIt()),
      child: BlocBuilder<InfoNoteScreenBloc, InfoNoteScreenState>(
        builder: (context, state) {
          return Scaffold(
            body: switch (state) {
              InfoNoteInitial() => InfoNoteWidget(
                note: widget.note,
                textNoteController: _textNoteController,
              ),
              InfoNoteLoading() => const Center(
                child: CircularProgressIndicator(),
              ),

              InfoNoteLoaded() => InfoNoteWidget(
                note: state.note,
                textNoteController: _textNoteController,
              ),
              InfoNoteError() => Center(
                child: Text(state.exception.toString()),
              ),
              InfoNoteDeleted() => const Center(
                child: CircularProgressIndicator(),
              ),
            },
          );
        },
      ),
    );
  }
}
