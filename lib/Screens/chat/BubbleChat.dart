import 'package:bp/models/chatmodel.dart';
import 'package:bp/user_preferences.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../size_config.dart';

class BubbleChat extends StatelessWidget {
  const BubbleChat({
    Key key,
    @required this.data,
  }) : super(key: key);

  final ChatModel data;
  @override
  Widget build(BuildContext context) {
    final preferences = UserPreferences();

    return Row(
      mainAxisAlignment: data.sendBy == preferences.userId
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          margin:
              EdgeInsets.symmetric(horizontal: getPSW(10), vertical: getPSH(5)),
          padding: EdgeInsets.all(getPSW(10)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(getPSW(10)),
                  topRight: Radius.circular(getPSW(10)),
                  bottomLeft: Radius.circular(getPSW(10)),
                  bottomRight: Radius.circular(getPSW(10))),
              color: kPrimeryColor),
          child: Text(
            data.message,
            overflow: TextOverflow.clip,
            // maxLines: ,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: getPSW(14),
            ),
          ),
        ),
      ],
    );
  }
}
