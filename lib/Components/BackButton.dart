import 'package:flutter/material.dart';

import '../colors.dart';
import '../size_config.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key key,
    this.pressd,
  }) : super(key: key);

  final pressd;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.only(left: getPSW(10)),
      height: getPSH(50),
      width: getPSW(50),
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white38),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          width: getPSW(45),
          height: getPSH(38),
          child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                size: getPSH(25),
                color: kPrimeryColor,
              ),
              onPressed: () {
                pressd();
              }),
        ),
      ),
    );
  }
}
