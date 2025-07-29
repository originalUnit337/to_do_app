import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/domain/entities/note.dart';
import 'package:to_do_app/firebase_config/bloc/firebase_config_bloc.dart';
import 'package:to_do_app/firebase_config/bloc/firebase_config_state.dart';
import 'package:to_do_app/injection_container.dart' show getIt;
import 'package:to_do_app/navigation/app_routes.dart';
import 'package:to_do_app/presentation/screens/home_screen/bloc/home_screen_bloc.dart';
import 'package:to_do_app/presentation/screens/home_screen/bloc/home_screen_event.dart';
import 'package:to_do_app/presentation/screens/home_screen/bloc/home_screen_state.dart';
import 'package:to_do_app/presentation/screens/home_screen/widgets/notes_list.dart';
import 'package:to_do_app/presentation/ui_kit/palette/app_palette.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final currentPalette = AppPalette.of(context);
    return BlocProvider<HomeScreenBloc>(
      create:
          (_) =>
              HomeScreenBloc(getIt(), getIt(), getIt(), getIt(), getIt())
                ..add(const GetAllNotesEvent()),
      child: BlocSelector<FirebaseConfigBloc, FirebaseConfigState, Color?>(
        selector: (state) {
          return state.floatActionButtonColor;
        },
        builder: (context, floatActionButtonColor) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            floatingActionButton: BlocSelector<
              HomeScreenBloc,
              HomeScreenState,
              List<NoteEntity>?
            >(
              selector: (state) {
                if (state is NotesLoaded) {
                  return state.notes;
                }
                return null;
              },
              builder: (context, notes) {
                return FloatingActionButton(
                  onPressed: () async {
                    final note =
                        await GoRouter.of(
                              context,
                            ).pushNamed(AppRoutes.infoNote.name)
                            as NoteEntity?;
                    if (context.mounted && note != null) {
                      notes?.add(note);
                      context.read<HomeScreenBloc>().add(
                        RefreshNotesEvent(notes ?? []),
                      );
                    }
                  },
                  child: Icon(Icons.add, color: currentPalette.colorWhite),
                  backgroundColor:
                      floatActionButtonColor ?? currentPalette.colorBlue,
                );
              },
            ),
            body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
              builder: (context, state) {
                return switch (state) {
                  NotesInitial() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  NotesLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  NotesLoaded() => NotesList(
                    noteItems: state.notes ?? [],
                    showCompleted: state.showCompleted,
                  ),
                  NotesError() => Center(
                    child: Text(state.exception?.message ?? 'Error'),
                  ),
                };
              },
            ),
          );
        },
      ),
    );
  }
}
