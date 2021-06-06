import 'package:bp/Components/BackButton.dart';
import 'package:bp/Components/loadingWidget.dart';
import 'package:bp/colors.dart';
import 'package:bp/models/beauty_centers.dart';
import 'package:bp/models/stylists.dart';
import 'package:bp/services/centers_services.dart';

import 'package:bp/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
    final stylists = Provider.of<CenterProivder>(context, listen: false);

    return Column(
      children: List.generate(
        centersData.stylists.length,
        (index) => StreamBuilder<StylistData>(
            stream: stylists.stylitys(centersData.stylists[index]),
            builder: (context, snap) {
              if (snap.data != null) {
                return StylistsCard(
                  data: snap.data,
                );
              } else {
                return LoadingWidget();
              }
            }),
      ),
    );
  }
}

class StylistsCard extends StatelessWidget {
  const StylistsCard({
    Key key,
    @required this.data,
  }) : super(key: key);

  final StylistData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: getPSH(10)),
      height: getPSH(90),
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            spreadRadius: 0,
            offset: Offset(0, 1),
            blurRadius: 9.0,
            color: Colors.grey[350])
      ], borderRadius: BorderRadius.circular(getPSW(20)), color: Colors.white),
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
          Container(
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
          SizedBox(width: getPSW(20))
        ],
      ),
    );
  }
}
//
