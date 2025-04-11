import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:to_do_app/firebase_options.dart';
import 'package:to_do_app/presentation/screens/home_screen.dart';
import 'package:to_do_app/presentation/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.appTheme,
      //home: Scaffold( body: Center(child: Text('Hello World!'),),),
      home: HomeScreen(),
    );
  }
}
