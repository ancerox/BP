import 'package:bp/Components/loadingWidget.dart';
import 'package:bp/colors.dart';
import 'package:bp/models/beauty_centers.dart';
import 'package:bp/models/user_models.dart';
import 'package:bp/services/centers_services.dart';
import 'package:bp/services/user_services.dart';
import 'package:bp/size_config.dart';
import 'package:bp/models/beauty_centers.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          // final provider = Provider.of<CenterProivder>(context, listen: false);

          // provider.centersList

          await FirebaseAuth.instance.signOut();
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
        if (snap.data != null) {
          return Column(
            children: List.generate(
                snap.data.length,
                (index) => StreamBuilder(
                      stream: provider.centerData(snap.data[index]),
                      builder: (context, snap) {
                        return centerCard(snap.data);
                      },
                    )),
          );
        }

        return Container();
      },
    );
  }

  Widget centerCard(data) {
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
                  image: NetworkImage(data['fotoUrl']),
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
                      data['name'],
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

  addCenter() {
    // final provider = Provider.of<UserServices>(context, listen: false);

    // provider.centersList();

    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         actions: [
    //           IconButton(
    //               icon: Text('Buscar'),
    //               onPressed: () {
    //                 provider.addCenter(centerCodeCtr.text);
    //                 print(centerCodeCtr.text);
    //               })
    //         ],
    //         content: TextFormField(
    //           controller: centerCodeCtr,
    //         ),
    //       );
    //     });
  }
}

//  return Container(
//           height: getPSH(130),
//           width: getPSW(305),
//           decoration: BoxDecoration(boxShadow: [
//             BoxShadow(
//                 spreadRadius: 0,
//                 offset: Offset(0, 1),
//                 blurRadius: 9.0,
//                 color: Colors.grey[350])
//           ], borderRadius: BorderRadius.circular(getPSH(20)), color: kLightBlueC),
//           child: Align(
//               child: RichText(
//             textAlign: TextAlign.center,
//             text: TextSpan(children: [
//               TextSpan(
//                 text:
//                     'Aun no tienes centros de belleza registrados puedes agregar tocando el ',
//                 style: TextStyle(color: kLightColor, fontSize: getPSH(18)),
//               ),
//               TextSpan(
//                 text: 'boton de agregar abajo',
//                 style: TextStyle(color: Colors.black, fontSize: getPSH(18)),
//               ),
//             ]),
//           )),
//         );
