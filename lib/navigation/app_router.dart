import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:go_router/go_router.dart';
import 'package:talker/talker.dart';
import 'package:to_do_app/domain/entities/note.dart';
import 'package:to_do_app/navigation/app_routes.dart';
import 'package:to_do_app/presentation/screens/home_screen/home_screen.dart';
import 'package:to_do_app/presentation/screens/info_note_screen/info_note_screen.dart';

class AppRouter {
  static final Talker _talker = Talker(settings: TalkerSettings());
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(
    analytics: analytics,
  );
  static final GoRouter router = GoRouter(
    observers: [observer],
    routes: [
      GoRoute(
        path: AppRoutes.homeRoute.path,
        name: AppRoutes.homeRoute.name,
        builder: (context, state) {
          _talker
            ..log('Going to HomeScreen...')
            ..log('LOGGIN EVENT test_homeScreen to firebase analytics...');
          analytics.logEvent(name: 'open_homeScreen');

          return const HomeScreen();
        },
        routes: [
          GoRoute(
            path: AppRoutes.infoNote.path,
            name: AppRoutes.infoNote.name,
            builder: (context, state) {
              _talker.log(
                'LOGGIN EVENT test_infoNoteScreen to firebase analytics...',
              );
              final note = state.extra as NoteEntity?;
              _talker.log('Note: $note');
              analytics.logEvent(
                name: 'open_infoNoteScreen',
                parameters: <String, Object>{
                  'id': note?.id ?? '',
                  'importance': note?.importance.label ?? '',
                  'isCompleted': note?.isCompleted.toString() ?? '',
                  'textNote': note?.textNote ?? '',
                  'makeBefore': note?.makeBefore?.toIso8601String() ?? '',
                },
              );
              return InfoNoteScreen(note: note);
            },
          ),
        ],
      ),
    ],
  );
}
