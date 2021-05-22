import 'package:flutter/material.dart';

import '../colors.dart';
import '../size_config.dart';
import 'BackButton.dart';

Widget appbar(BuildContext context, {text}) {
  SizeConfig().init(context);
  return Row(
    children: [
      CustomBackButton(),
      Spacer(),
      Text(
        text,
        style: TextStyle(
            fontSize: getPSH(20),
            color: kPrimeryColor,
            fontWeight: FontWeight.w800),
      ),
      Spacer(
        flex: 2,
      ),
    ],
  );
}
