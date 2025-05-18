import 'package:go_router/go_router.dart';
import 'package:to_do_app/navigation/app_routes.dart';
import 'package:to_do_app/presentation/screens/add_note_screen.dart';
import 'package:to_do_app/presentation/screens/home_screen.dart';

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
        path: AppRoutes.addNote.path,
        name: AppRoutes.addNote.name,
        builder: (context, state) {
          return const AddNoteScreen();
        },
      ),
    ],
  );
}
