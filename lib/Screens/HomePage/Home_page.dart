import 'package:bp/Components/customButton.dart';
import 'package:bp/Components/loadingWidget.dart';
import 'package:bp/Screens/HomePage/center_card.dart';
import 'package:bp/Screens/center/center_page.dart';
import 'package:bp/colors.dart';
import 'package:bp/models/beauty_centers.dart';

import 'package:bp/models/user_models.dart';
import 'package:bp/services/centers_services.dart';
import 'package:bp/services/user_services.dart';
import 'package:bp/size_config.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'no_centters_added.dart';

TextEditingController centerCodeCtr = TextEditingController();

class HomePage extends StatefulWidget {
  static String route = 'home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimeryColor,
        onPressed: () async {
          addCenter();
          // await FirebaseAuth.instance.signOut();
        },
        child: Icon(
          Icons.add,
          size: getPSW(35),
        ),
      ),
      body: SafeArea(child: body()),
    );
  }

  Widget body() {
    final provider = Provider.of<UserServices>(context);

    return StreamBuilder<UserData>(
        stream: provider.userData,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //
                    appbar(snapshot),
                    //

                    bodyPart(),
                    //
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: LoadingWidget(),
            );
          }
        });
  }

  Widget appbar(snapshot) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            iconSize: getPSH(25),
            onPressed: () {},
            icon: Image(
              image: AssetImage('assets/icons/menu.png'),
            ),
          ),
          RichText(
            textAlign: TextAlign.right,
            text: TextSpan(
              style: TextStyle(),
              children: <TextSpan>[
                TextSpan(
                  text: 'Buenos dias\n',
                  // textAlign: TextAlign.right,
                  style: TextStyle(
                      color: kLightColor,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      fontSize: getPSH(22)),
                ),
                TextSpan(
                  text: snapshot.data.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                      fontSize: getPSH(20)),
                )
              ],
              //
            ),
          )
        ],
      ),
    );
  }

  Widget bodyPart() {
    return Container(
      margin: EdgeInsets.only(top: 40, left: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pendiente',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: getPSH(25)),
          ),
          SizedBox(
            height: 20,
          ),
          pendding(),
          SizedBox(
            height: 20,
          ),
          Text(
            'Tus centros',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: getPSH(20),
                color: kLightColor),
          ),
          SizedBox(
            height: 20,
          ),
          centers(),
        ],
      ),
    );
  }

  Widget pendding() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: getPSH(80),
      width: getPSW(305),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            spreadRadius: 0,
            offset: Offset(0, 1),
            blurRadius: 9.0,
            color: Colors.grey[350])
      ], borderRadius: BorderRadius.circular(getPSH(20)), color: kLightBlueC),
      child: Align(
          alignment: Alignment.centerLeft,
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Aun no tienes citas\n',
                style: TextStyle(color: kLightColor, fontSize: getPSH(18)),
              ),
              TextSpan(
                text: 'Pendientes',
                style: TextStyle(color: Colors.black, fontSize: getPSH(18)),
              ),
            ]),
          )),
    );
  }

  Widget centers() {
    final provider = Provider.of<CenterProivder>(context, listen: false);

    return StreamBuilder(
      stream: provider.centerIds,
      builder: (context, snap) {
        print(snap.data);
        if (snap.data != null) {
          if (snap.data.length > 0) {
            return Column(
              children: List.generate(
                  snap.data.length,
                  (index) => StreamBuilder<CentersData>(
                        stream: provider.centerData(snap.data[index]),
                        builder: (context, snap) {
                          if (snap.data != null) {
                            return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, CenterPage.route);
                                },
                                child: CenterCard(data: snap.data));
                          } else {
                            return Container();
                          }
                        },
                      )),
            );
          }
          return NoCenttersAdded();
        }

        return Container();
      },
    );
  }

  addCenter() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              content: Container(
                decoration: BoxDecoration(),
                width: getPSW(100),
                height: getPSH(150),
                child: Stack(children: [
                  Column(
                    children: [
                      Align(
                        // These values are based on trial & error method
                        alignment: Alignment(1.07, -1.08),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: getPSH(40),
                            width: getPSW(40),
                            decoration: BoxDecoration(
                              color: kPrimeryColor,
                              borderRadius: BorderRadius.circular(getPSH(20)),
                            ),
                            child: Icon(
                              Icons.close,
                              size: getPSH(30),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Text(
                        'Agrega tu centro de belleza',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )),
                      Expanded(
                          child: TextField(
                        style: TextStyle(fontSize: getPSH(20)),
                        controller: centerCodeCtr,
                      )),
                      Expanded(
                        child: CustomButton(
                          context: context,
                          text: 'agregar',
                          pressd: () {
                            final provider = Provider.of<CenterProivder>(
                                context,
                                listen: false);
                            provider.addCenter(centerCodeCtr.text);
                          },
                        ),
                      ),
                    ],
                  ),
                ]),
              ));
        });
  }
}
