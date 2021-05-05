import 'package:bp/colors.dart';
import 'package:bp/routes.dart';
import 'package:flutter/material.dart';

import 'Screens/splash_S.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: routes,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColorBrightness: Brightness.dark,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: kBackGColor,
            fontFamily: 'Kohinoor Bangla'),
        title: 'Material App',
        home: SplashScreen());
  }
}
