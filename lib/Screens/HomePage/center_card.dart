import 'package:bp/models/beauty_centers.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';

class CenterCard extends StatelessWidget {
  const CenterCard({
    Key key,
    @required this.data,
  }) : super(key: key);

  final CentersData data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: getPSH(10)),
        height: getPSH(120),
        width: getPSW(328),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(getPSH(17)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0,
                  offset: Offset(0, 1),
                  blurRadius: 9.0,
                  color: Colors.grey[350])
            ]),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(data.fotoUrl),
                ),
              ),
              width: getPSW(100),
              height: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 10,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: getPSW(15), bottom: getPSH(15), top: getPSH(15)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
                      style: TextStyle(
                          height: getPSH(1.5),
                          fontSize: getPSW(18),
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'Desde 8:00 Am',
                      style: TextStyle(
                          height: getPSH(1.5),
                          fontSize: getPSW(10),
                          fontWeight: FontWeight.w200),
                    ),
                    Text(
                      'Hasta 5:00 Pm',
                      style: TextStyle(
                          fontSize: getPSW(10), fontWeight: FontWeight.w200),
                    ),
                    SizedBox(
                      height: getPSH(5),
                    ),
                    Row(
                      children: [
                        ...List.generate(
                            3,
                            (index) => CircleAvatar(
                                  maxRadius: getPSH(12),
                                ))
                      ],
                    )
                  ]),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.only(left: getPSH(40), bottom: getPSH(20)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Abierto',
                      style: TextStyle(
                          fontSize: getPSH(12), fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      width: getPSW(5),
                    ),
                    Icon(
                      Icons.circle,
                      color: Color(0xff74EFAD),
                      size: getPSH(14),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
