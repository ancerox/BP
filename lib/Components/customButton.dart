import 'package:bp/size_config.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
    @required this.text,
    @required this.context,
    @required this.pressd,
  }) : super(key: key);

  final BuildContext context;
  final Function pressd;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: pressd,
        child: Container(
          width: getPSW(320),
          height: getPSH(50),
          decoration: BoxDecoration(
              color: kSecundary, borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
