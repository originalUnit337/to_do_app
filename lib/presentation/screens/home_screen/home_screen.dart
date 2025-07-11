import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/firebase_config/bloc/firebase_config_bloc.dart';
import 'package:to_do_app/firebase_config/bloc/firebase_config_event.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<FirebaseConfigBloc>(
          lazy: false,
          create:
              (_) =>
                  FirebaseConfigBloc()..add(const RefreshFirebaseConfigEvent()),
        ),
        BlocProvider<HomeScreenBloc>(
          create:
              (_) =>
                  HomeScreenBloc(getIt(), getIt(), getIt(), getIt())
                    ..add(const GetAllNotesEvent()),
        ),
      ],
      child: BlocBuilder<FirebaseConfigBloc, FirebaseConfigState>(
        builder: (_, _) {
          return Builder(
            builder: (context) {
              final floatActionButtonColor = getIt<FirebaseRemoteConfig>()
                  .getString('floatActionButtonColour');
              return Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                floatingActionButton: FloatingActionButton(
                  onPressed: () async {
                    await GoRouter.of(
                      context,
                    ).pushNamed(AppRoutes.infoNote.name);
                    if (context.mounted) {
                      context.read<HomeScreenBloc>().add(
                        const GetAllNotesEvent(),
                      );
                    }
                  },
                  child: Icon(Icons.add, color: currentPalette.colorWhite),
                  backgroundColor: Color(int.parse(floatActionButtonColor)),
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
          );
        },
      ),
    );
  }
}
