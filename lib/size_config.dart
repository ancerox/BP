import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenHeight;
  static double screenWidth;
  static double defaultSize;
  static Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenHeight = _mediaQueryData.size.height;
    screenWidth = _mediaQueryData.size.width;
    orientation = _mediaQueryData.orientation;
  }
}

double getPSH(double height) {
  double screenHeight = SizeConfig.screenHeight;
  return (height / 812) * screenHeight;
}

double getPSW(double width) {
  double screenWidht = SizeConfig.screenWidth;
  return (width / 375) * screenWidht;
}
