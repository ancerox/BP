import 'package:bp/Components/BackButton.dart';
import 'package:bp/models/beauty_centers.dart';

import 'package:flutter/material.dart';

import '../../size_config.dart';

Widget imageCenter(CentersData center, BuildContext context, Function pressed) {
  return SliverAppBar(
    iconTheme: IconThemeData(
      color: Colors.transparent, //change your color here
    ),
    expandedHeight: 300,
    floating: false,
    pinned: true,
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(getPSW(60)),
      child: Text(''),
    ),
    flexibleSpace: Container(
      padding: EdgeInsets.all(10),
      height: getPSW(340),
      width: double.infinity,
      child: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: getPSH(30),
            ),
            CustomBackButton(
              pressd: pressed,
            ),
            Spacer(
              flex: 4,
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: getPSW(20)),
              child: Text(
                center.name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: getPSW(24),
                    fontWeight: FontWeight.w700),
              ),
            )),
          ],
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(getPSH(0)),
          color: Colors.black.withOpacity(1),
          image: DecorationImage(
              image: NetworkImage(center.fotoUrl),
              colorFilter: ColorFilter.mode(
                  Colors.grey.withOpacity(0.9), BlendMode.dstATop),
              fit: BoxFit.cover)),
    ),
  );
}
