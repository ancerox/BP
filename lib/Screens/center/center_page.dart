import 'package:bp/Components/loadingWidget.dart';
import 'package:bp/Screens/center/stylist_card.dart';
import 'package:bp/colors.dart';
import 'package:bp/models/beauty_centers.dart';
import 'package:bp/models/stylists.dart';
import 'package:bp/services/centers_services.dart';

import 'package:bp/size_config.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../user_preferences.dart';
import 'image_center.dart';

class CenterPage extends StatefulWidget {
  CenterPage({Key key}) : super(key: key);
  static String route = 'centerPage';
  @override
  _CenterPageState createState() => _CenterPageState();
}

class _CenterPageState extends State<CenterPage> {
  @override
  Widget build(BuildContext context) {
    final CentersData centersData = ModalRoute.of(context).settings.arguments;
    SizeConfig().init(context);

    final prefs = UserPreferences();

    final chatRoomId = Provider.of<CenterProivder>(context)
        .getChatRoomId(prefs.userId, '18298281232');

    Map<String, dynamic> chatRoominfoMap = {
      "users": [prefs.userId, '18298281232'],
    };

    Provider.of<CenterProivder>(context)
        .createChatRoom(chatRoomId, chatRoominfoMap);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            decoration: BoxDecoration(
                color: kSecundary, borderRadius: BorderRadius.circular(20)),
            width: getPSW(270),
            height: getPSH(55),
            child: new RawMaterialButton(
              child: Text(
                'Solicitar Servicio',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
              onPressed: () {
                DateTime now = DateTime.now();
                print(now.hour);
              },
            )),
      ),
      body: CustomScrollView(
        slivers: [
          imageCenter(centersData, context),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.all(getPSH(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: getPSH(50),
                        width: getPSW(100),
                        decoration: BoxDecoration(
                            color: kLightBlueC,
                            borderRadius: BorderRadius.circular(getPSW(10))),
                        child: Center(
                          child: Text(
                            'Estilistas',
                            style: TextStyle(
                                color: kLightColor,
                                fontWeight: FontWeight.w600,
                                fontSize: getPSH(18)),
                          ),
                        ),
                      ),
                      buildStylistsList(centersData),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column buildStylistsList(CentersData centersData) {
    final stylist = Provider.of<CenterProivder>(context, listen: false);

    return Column(
      children: List.generate(
        centersData.stylists.length,
        (index) => StreamBuilder<StylistData>(
            stream: stylist.stylitys(centersData.stylists[index]),
            builder: (context, snap) {
              if (snap.data != null) {
                return StylistsCard(
                  data: snap.data,
                  stylisyId: centersData.stylists[index],
                );
              } else {
                return LoadingWidget();
              }
            }),
      ),
    );
  }
}
