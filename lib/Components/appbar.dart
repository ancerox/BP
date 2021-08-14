import 'package:flutter/material.dart';

import '../colors.dart';
import '../size_config.dart';
import 'BackButton.dart';

Widget appbar(BuildContext context, String text, String stylistName) {
  SizeConfig().init(context);
  return Row(
    children: [
      CustomBackButton(
        pressd: () {
          Navigator.pop(context);
        },
      ),
      Spacer(),
      Column(
        children: [
          Text(
            text,
            style: TextStyle(
                fontSize: getPSH(20),
                color: kPrimeryColor,
                fontWeight: FontWeight.w800),
          ),
          Text(
            stylistName,
            style: TextStyle(fontSize: getPSW(15), fontWeight: FontWeight.w500),
          )
        ],
      ),
      Spacer(
        flex: 2,
      ),
    ],
  );
}
