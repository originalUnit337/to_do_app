import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:to_do_app/firebase_config/bloc/firebase_config_bloc.dart';
import 'package:to_do_app/firebase_options.dart';
import 'package:to_do_app/injection_container.dart';
import 'package:to_do_app/localization/l10n/l10n.dart';
import 'package:to_do_app/navigation/app_router.dart';
import 'package:to_do_app/presentation/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initializeDependencies();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FirebaseConfigBloc>(
      lazy: false,
      create: (_) => FirebaseConfigBloc(),
      child: MaterialApp.router(
        supportedLocales: L10n.all,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        theme: AppTheme.lightAppTheme,
        darkTheme: AppTheme.darkAppTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
