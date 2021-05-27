import 'package:bp/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SpinKitFoldingCube(
          // controller: ,
          // duration: Duration(seconds: 5),
          color: kPrimeryColor,
          size: 50.0,
        ),
      ),
    );
  }
}
