import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bp/services/centers_services.dart';
import 'package:bp/services/user_services.dart';

import 'package:flutter/services.dart';
import 'package:bp/routes.dart';
import 'package:bp/theme.dart';
import 'package:bp/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPreferences();
  await prefs.initPrefs();

  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CenterProivder(),
        ),
        ChangeNotifierProvider(
          create: (_) => new UserServices(),
        )
      ],
      child: MaterialApp(
        routes: routes,
        debugShowCheckedModeBanner: false,
        theme: themedata(),
        title: 'Material App',
        initialRoute: 'authWraped',
      ),
    );
  }
}
