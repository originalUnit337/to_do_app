import 'dart:convert';

import 'package:go_router/go_router.dart';
import 'package:to_do_app/domain/entities/note.dart';
import 'package:to_do_app/navigation/app_routes.dart';
import 'package:to_do_app/presentation/screens/home_screen/home_screen.dart';
import 'package:to_do_app/presentation/screens/info_note_screen/info_note_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.homeRoute.path,
        name: AppRoutes.homeRoute.name,
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.infoNote.path,
        name: AppRoutes.infoNote.name,
        builder: (context, state) {
          final noteJson = state.pathParameters['data'];
          final note =
              noteJson != null
                  ? NoteEntity.fromJson(
                    jsonDecode(noteJson) as Map<String, dynamic>,
                  )
                  : null;

          return InfoNoteScreen(note: note);
        },
      ),
    ],
  );
}
