import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:to_do_app/firebase_options.dart';
import 'package:to_do_app/localization/l10n/l10n.dart';
import 'package:to_do_app/navigation/app_router.dart';
import 'package:to_do_app/presentation/screens/home_screen.dart';
import 'package:to_do_app/presentation/theme/app_theme.dart';
import 'package:to_do_app/presentation/ui_kit/palette/dark.dart';
import 'package:to_do_app/presentation/ui_kit/palette/light.dart';
import 'package:to_do_app/presentation/ui_kit/palette/palette_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPalette = MediaQuery.of(context).platformBrightness == Brightness.light ? LightPalette() : DarkPalette();
    return PaletteProvider(
      palette: currentPalette,
      child: MaterialApp.router(
        supportedLocales: L10n.all,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        theme: AppTheme.getAppTheme(currentPalette),
        //darkTheme: AppTheme.darkAppTheme,
        routerConfig: AppRouter.router,
        // routeInformationParser: AppRouter.router.routeInformationParser,
        // routerDelegate: AppRouter.router.routerDelegate,
      ),
    );
  }
}
