import 'package:flutter/material.dart';

import '../colors.dart';
import '../size_config.dart';

class Hour extends StatelessWidget {
  const Hour({Key key, @required this.hour})
      : super(
          key: key,
        );

  final String hour;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hour,
          style: TextStyle(
              color: kLightColor,
              fontWeight: FontWeight.w500,
              fontSize: getPSW(19)),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: getPSH(7),
              width: getPSW(25),
              decoration: BoxDecoration(
                  color: Color(0xffC7C7C7),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: getPSH(7),
          width: getPSW(55),
          decoration: BoxDecoration(
              color: Color(0xffC7C7C7),
              borderRadius: BorderRadius.circular(20)),
        ),
        SizedBox(
          height: getPSH(15),
        ),
      ],
    );
  }
}
