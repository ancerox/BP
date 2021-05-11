import 'package:bp/Screens/codeSms/CodeSms_S.dart';
import 'package:bp/Screens/log%20in/login_S.dart';
import 'package:flutter/material.dart';

import 'Screens/Register/Register_P.dart';

Map<String, WidgetBuilder> routes = {
  LoginPage.routeName: (_) => LoginPage(),
  RegisterPage.routeName: (_) => RegisterPage(),
  SmsPage.route: (_) => SmsPage()
};
