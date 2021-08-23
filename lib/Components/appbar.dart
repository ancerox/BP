import 'package:bp/models/stylists.dart';
import 'package:flutter/material.dart';

import '../colors.dart';
import '../size_config.dart';
import 'BackButton.dart';

Widget appbar(BuildContext context, String text, Stream stylistStreamData) {
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
          StreamBuilder<StylistData>(
              stream: stylistStreamData,
              builder: (context, snapshot) {
                return Text(
                  snapshot.data != null ? snapshot.data.name : '#####',
                  style: TextStyle(
                      fontSize: getPSW(15), fontWeight: FontWeight.w500),
                );
              })
        ],
      ),
      Spacer(
        flex: 2,
      ),
    ],
  );
}
