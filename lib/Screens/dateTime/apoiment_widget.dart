import 'package:bp/Components/Hour.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../size_config.dart';

class ApoimentWidget extends StatelessWidget {
  const ApoimentWidget({
    Key key,
    @required this.hora,
  }) : super(key: key);

  final String hora;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hour(
          hour: '$hora',
        ),
        Spacer(),
        Container(
          width: getPSW(230),
          height: getPSH(55),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(getPSW(10)),
              color: kSecundary),
          child: Center(
            child: Text(
              'Ocupado',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: getPSW(16),
              ),
            ),
          ),
        )
      ],
    );
  }
}
