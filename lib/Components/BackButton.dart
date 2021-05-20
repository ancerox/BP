import 'package:flutter/material.dart';

import '../colors.dart';
import '../size_config.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.only(left: 20),
      height: getPSH(50),
      width: getPSW(50),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white38),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          width: getPSW(44),
          height: getPSH(44),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              size: 30,
              color: kPrimeryColor,
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
