import 'package:bp/Screens/HomePage/Home_page.dart';
import 'package:bp/Screens/Splash/splash_S.dart';
import 'package:bp/Screens/center/center_page.dart';
import 'package:bp/Screens/chat/chat_page.dart';
import 'package:bp/Screens/codeSms/CodeSms_S.dart';
import 'package:bp/Screens/log%20in/login_S.dart';
import 'package:bp/authWrapped.dart';
import 'package:flutter/material.dart';

import 'Screens/Register/Register_P.dart';
import 'Screens/ServicesStylists/services_Stylists_page.dart';
import 'Screens/dateTime/dateTime_Screen.dart';
import 'Screens/lobby/lobby_page.dart';

Map<String, WidgetBuilder> routes = {
  LoginPage.routeName: (_) => LoginPage(),
  RegisterPage.routeName: (_) => RegisterPage(),
  SmsPage.routeName: (_) => SmsPage(),
  HomePage.route: (_) => HomePage(),
  AuthWraped.route: (_) => AuthWraped(),
  CenterPage.route: (_) => CenterPage(),
  SplashScreen.route: (_) => SplashScreen(),
  DateTimePage.route: (_) => DateTimePage(),
  ChatScreen.route: (_) => ChatScreen(),
  ServicesStylists.route: (_) => ServicesStylists(),
  LobbyPage.route: (_) => LobbyPage(),
};
