import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../size_config.dart';

class NoCenttersAdded extends StatelessWidget {
  const NoCenttersAdded({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getPSH(130),
      width: getPSW(305),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            spreadRadius: 0,
            offset: Offset(0, 1),
            blurRadius: 9.0,
            color: Colors.grey[350])
      ], borderRadius: BorderRadius.circular(getPSH(20)), color: kLightBlueC),
      child: Align(
          child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
            text:
                'Aun no tienes centros de belleza registrados puedes agregar tocando el ',
            style: TextStyle(color: kLightColor, fontSize: getPSH(18)),
          ),
          TextSpan(
            text: 'boton de agregar abajo',
            style: TextStyle(color: Colors.black, fontSize: getPSH(18)),
          ),
        ]),
      )),
    );
  }
}
