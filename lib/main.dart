import 'package:bp/Screens/center/center_page.dart';
import 'package:bp/Screens/codeSms/CodeSms_S.dart';
import 'package:bp/Screens/dateTime/dateTime_Screen.dart';
import 'package:bp/colors.dart';
import 'package:bp/routes.dart';
import 'package:bp/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Screens/HomePage/Home_page.dart';
import 'Screens/Splash/splash_S.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: routes,
        debugShowCheckedModeBanner: false,
        theme: themedata(),
        title: 'Material App',
        home: DateTimePage());
  }
}
