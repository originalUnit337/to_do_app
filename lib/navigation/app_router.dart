import 'package:go_router/go_router.dart';
import 'package:to_do_app/navigation/app_routes.dart';
import 'package:to_do_app/presentation/screens/add_note_screen.dart';
import 'package:to_do_app/presentation/screens/home_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: AppRoutes.homeRouteName,
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: '/add_note',
        name: AppRoutes.addNoteName,
        builder: (context, state) {
          return const AddNoteScreen();
        },
      ),
    ],
  );
}
