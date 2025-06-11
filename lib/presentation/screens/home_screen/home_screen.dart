import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:to_do_app/domain/entities/note.dart' show NoteEntity;
import 'package:to_do_app/injection_container.dart' show getIt;
import 'package:to_do_app/presentation/screens/home_screen/bloc/home_screen_bloc.dart';
import 'package:to_do_app/presentation/screens/home_screen/bloc/home_screen_event.dart';
import 'package:to_do_app/presentation/screens/home_screen/bloc/home_screen_state.dart';
import 'package:to_do_app/presentation/screens/home_screen/widgets/build_notes_list.dart';
import 'package:to_do_app/presentation/screens/info_note_screen/info_note_screen.dart';
import 'package:to_do_app/presentation/ui_kit/font/app_font_style.dart';
import 'package:to_do_app/presentation/ui_kit/palette/app_palette.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final currentPalette = AppPalette.of(context);
    return BlocProvider<HomeScreenBloc>(
      create:
          (context) => HomeScreenBloc(getIt())..add(const GetAllNotesEvent()),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //GoRouter.of(context).pushNamed(AppRoutes.addNote.name);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const InfoNoteScreen();
                },
              ),
            );
          },
          child: Icon(Icons.add, color: currentPalette.colorWhite),
          backgroundColor: currentPalette.colorBlue,
        ),
        body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
          builder: (context, state) {
            return switch (state) {
              NotesInitial() => const Center(child: Text('Initial')),
              NotesLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              NotesLoaded() => BuildNotesList(noteItems: state.notes ?? []),
              NotesError() => Center(
                child: Text(state.exception?.message ?? 'Error'),
              ),
            };
          },
        ),
      ),
    );
  }
}
