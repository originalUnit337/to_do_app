import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do_app/firebase_options.dart';
import 'package:to_do_app/injection_container.dart';
import 'package:to_do_app/localization/l10n/l10n.dart';
import 'package:to_do_app/navigation/app_router.dart';
import 'package:to_do_app/presentation/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initializeDependencies();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _appLinks = GetIt.I<AppLinks>();
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  Future<void> initDeepLinks() async {
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      debugPrint('Received deep link: $uri');
      handleDeepLink(uri);
    });
  }

  void handleDeepLink(Uri uri) {
    final routeName = uri.fragment.isNotEmpty ? uri.fragment : '/';
    AppRouter.router.go(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      supportedLocales: L10n.all,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: AppTheme.lightAppTheme,
      darkTheme: AppTheme.darkAppTheme,
      routerConfig: AppRouter.router,
    );
  }
}
