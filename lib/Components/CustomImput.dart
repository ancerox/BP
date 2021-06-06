import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';

Widget customImput({
  BuildContext context,
  TextInputType keyboardType,
  String hintText,
  bool isPassword,
  IconData icon,
  Function validator,
  Function onChanged,
  TextEditingController textController,
}) {
  return Stack(children: [
    Container(
      margin: EdgeInsets.only(bottom: getPSH(20)),
      padding: EdgeInsets.only(
          right: getPSW(20),
          top: getPSH(5),
          bottom: getPSH(5),
          left: getPSH(5)),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(getPSW(30)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                blurRadius: 8,
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 5))
          ]),
      child: TextFormField(
        // focusNode: focusNode,
        onChanged: onChanged,
        validator: validator,
        autofocus: false,
        style: TextStyle(fontSize: getPSH(17)),
        controller: textController,
        obscureText: isPassword,
        keyboardType: keyboardType,
        autocorrect: false,
        decoration: InputDecoration(
          errorText: '',
          errorMaxLines: 1,
          errorStyle: TextStyle(
            height: getPSH(0),
            color: Colors.transparent,
            fontSize: getPSH(0),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(
              horizontal: getPSW(35), vertical: getPSH(10)),
          hintStyle: TextStyle(fontSize: getPSW(17)),
          hintText: hintText,
          suffixIcon: Icon(
            icon,
            size: getPSH(25),
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    ),
  ]);
}
