import 'package:bp/Screens/Register/Register_P.dart';

import 'package:bp/routes.dart';
import 'package:bp/services/user_services.dart';

import 'package:bp/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
          create: (_) => new UserServices(),
        )
      ],
      child: MaterialApp(
          routes: routes,
          debugShowCheckedModeBanner: false,
          theme: themedata(),
          title: 'Material App',
          home: RegisterPage()),
    );
  }
}
