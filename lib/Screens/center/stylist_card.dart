import 'package:bp/models/stylists.dart';
import 'package:bp/services/centers_services.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../colors.dart';
import '../../size_config.dart';

class StylistsCard extends StatelessWidget {
  const StylistsCard({Key key, @required this.data, this.stylistId, this.onTap})
      : super(key: key);

  final StylistData data;
  final String stylistId;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final List stylistList = [data, stylistId];

    //saving name of Stylist
    Provider.of<CenterProivder>(context).stylistName = data.name;

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: getPSH(10)),
        height: getPSH(90),
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0,
                  offset: Offset(0, 1),
                  blurRadius: 9.0,
                  color: Colors.grey[350])
            ],
            borderRadius: BorderRadius.circular(getPSW(20)),
            color: Colors.white),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(getPSH(20)),
                border: Border.all(
                  color: Colors.white,
                  width: getPSW(10),
                ),
              ),
              height: double.infinity,
              width: getPSW(70),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(getPSH(15)),
                child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: AssetImage('assets/loadingGif/LoadingLoop.gif'),
                  image: NetworkImage(data.photoUrl),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(getPSH(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      data.name,
                      style: TextStyle(
                          fontSize: getPSH(18), fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: getPSH(7)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Disponible',
                        style: TextStyle(fontSize: getPSW(13)),
                      ),
                      SizedBox(width: getPSW(5)),
                      Icon(
                        Icons.circle,
                        size: getPSH(12),
                        color: Color(0xff74EFAD),
                      )
                    ],
                  )
                ],
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'chat', arguments: stylistList);
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: kPrimeryColor,
                  borderRadius: BorderRadius.circular(
                    25,
                  ),
                ),
                child: Icon(
                  Icons.chat_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            SizedBox(width: getPSW(20))
          ],
        ),
      ),
    );
  }
}
