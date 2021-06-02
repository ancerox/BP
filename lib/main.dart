import 'package:bp/Screens/Splash/splash_S.dart';
import 'package:bp/Screens/log%20in/login_S.dart';

import 'package:bp/routes.dart';
import 'package:bp/services/centers_services.dart';
import 'package:bp/services/user_services.dart';

import 'package:bp/theme.dart';
import 'package:bp/user_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
    final prefs = UserPreferences();

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
