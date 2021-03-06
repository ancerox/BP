import 'package:bp/Screens/HomePage/drawer.dart';
import 'package:bp/services/user_services.dart';
import 'package:bp/size_config.dart';
import 'package:bp/services/centers_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import 'package:provider/provider.dart';

import 'package:bp/Screens/HomePage/center_card.dart';
import 'package:bp/Screens/center/center_page.dart';
import 'package:bp/colors.dart';
import 'package:bp/models/beauty_centers.dart';

import 'package:bp/models/user_models.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'no_centters_added.dart';

TextEditingController centerCodeCtr = TextEditingController();

final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
bool isFirstTime;

class HomePage extends StatefulWidget {
  static String route = 'home';
  @override
  _HomePageState createState() => _HomePageState();
}

GlobalKey keyOne = GlobalKey();

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ShowCaseWidget.of(context).startShowCase([keyOne]));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      drawer: MainDrawer(),
      key: _scafoldKey,
      floatingActionButton: Showcase(
        showArrow: true,
        shapeBorder: CircleBorder(),
        description: 'Agrega tu primer centro de belleza',
        key: keyOne,
        child: FloatingActionButton(
          backgroundColor: kPrimeryColor,
          onPressed: () {
            // addedSucces();
            addCenter();
          },
          child: Icon(
            Icons.add,
            size: getPSW(35),
          ),
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
              child: Container(),
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
            onPressed: () {
              _scafoldKey.currentState.openDrawer();
            },
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
                  text: 'Buenos Noches\n',
                  // textAlign: TextAlign.right,
                  style: TextStyle(
                      color: kLightColor,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      fontSize: getPSH(27)),
                ),
                TextSpan(
                  text: 'Juan',
                  style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                      fontSize: getPSH(22)),
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
    final userProvider = Provider.of<UserServices>(context);
    final centerProvider = Provider.of<CenterProivder>(context);

    return StreamBuilder<UserData>(
        stream: userProvider.userData,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return StreamBuilder(
                stream: centerProvider.currentApoiment(
                  snapshot.data.stylistIdCurrentApoiment,
                ),
                builder: (context, snapshot) {
                  if (snapshot.data != null && snapshot.data.docs.length > 0) {
                    final data = snapshot.data.docs[0];
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'lobby', arguments: data);
                      },
                      child: PeddingWidget(
                        // stylisyImage: ,
                        isLoading: false,
                        text: 'Tienes un Turno con \n',
                        text2: data['stylistName'],
                      ),
                    );
                  } else {
                    return PeddingWidget(
                        isLoading: false, text: 'No hay turnos Agendados');
                  }
                });
          } else {
            return PeddingWidget(
                isLoading: true, text: 'No hay turnos Agendados');
          }
        });
  }

  Widget centers() {
    final provider = Provider.of<CenterProivder>(context, listen: false);

    return StreamBuilder(
      stream: provider.centerIds,
      builder: (context, snap) {
        if (snap.data != null) {
          //Todo: change the path of the Stream Provider
          if (snap.data.isNotEmpty) {
            return Column(
              children: List.generate(
                  snap.data.length,
                  (index) => StreamBuilder<CentersData>(
                        stream: provider.centerData(snap.data[index]),
                        builder: (context, snap) {
                          if (snap.data != null) {
                            return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, CenterPage.route,
                                      arguments: snap.data);
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
                  Align(
                    // These values are based on trial & error method
                    alignment: Alignment(1.475, -1.6),
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
                  Column(
                    children: [
                      Text(
                        'Codigo de tu centro de belleza',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: getPSH(14)),
                      ),
                      TextField(
                        style: TextStyle(fontSize: getPSH(20)),
                        controller: centerCodeCtr,
                      ),
                      Spacer(flex: 2),
                      Container(
                        height: getPSH(35),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(getPSH(20)),
                            color: kPrimeryColor),
                        width: getPSW(150),
                        child: TextButton(
                          onPressed: () {
                            final provider = Provider.of<CenterProivder>(
                                context,
                                listen: false);

                            provider.addCenter(centerCodeCtr.text).then((e) {
                              if (e == null) {
                                // TODO: handel not center found
                              } else {
                                Navigator.pop(context);
                                addedSucces();
                              }
                            });
                          },
                          child: Text('Agregar',
                              style: TextStyle(
                                  fontSize: getPSH(15),
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                ]),
              ));
        });
  }

  addedSucces() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              content: Container(
                decoration: BoxDecoration(),
                width: getPSW(300),
                height: getPSH(150),
                child: Stack(
                  children: [
                    Align(
                      // These values are based on trial & error method
                      alignment: Alignment(0, -5.5),
                      child: SvgPicture.asset(
                        'assets/icons/success.svg',
                        width: getPSW(120),
                        height: getPSH(120),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: getPSH(60)),
                          Text('Centro Valido',
                              style: TextStyle(
                                  fontSize: getPSH(18),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(height: getPSH(5)),
                          Text('Centro de belleza agreado!'),
                          TextButton(
                            child: Text('Ok!'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ));
        });
  }
}

class PeddingWidget extends StatelessWidget {
  const PeddingWidget({
    Key key,
    this.text,
    this.isLoading,
    this.text2,
    this.stylisyImage,
  }) : super(key: key);

  final String text;
  final bool isLoading;
  final String text2;
  final String stylisyImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: getPSH(80),
      width: getPSW(305),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          spreadRadius: 0,
          offset: Offset(0, 1),
          blurRadius: 9.0,
          color: Colors.grey[350],
        )
      ], borderRadius: BorderRadius.circular(getPSH(20)), color: kLightBlueC),
      child: isLoading
          ? SpinKitWave(
              color: Colors.white,
              size: 50.0,
            )
          : Row(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: text,
                          style: TextStyle(
                              color: kLightColor, fontSize: getPSH(18)),
                        ),
                        TextSpan(
                          text: text2,
                          style: TextStyle(
                              color: Colors.black, fontSize: getPSH(18)),
                        ),
                      ]),
                    )),
                // Spacer(),
                // isLoading
                //     ? Container()
                //     : CircleAvatar(
                //         maxRadius: 30.0,
                //         child: Image(
                //           image: AssetImage(stylisyImage),
                //         ),
                //       )
              ],
            ),
    );
  }
}
