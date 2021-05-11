import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData themedata() {
  return ThemeData(
      textTheme: TextTheme(headline6: TextStyle(color: Colors.grey[700])),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          color: kBackGColor),
      scaffoldBackgroundColor: kBackGColor,
      fontFamily: 'Kohinoor Bangla');
}
