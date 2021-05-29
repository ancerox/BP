import 'package:bp/colors.dart';
import 'package:bp/services/user_services.dart';
import 'package:bp/size_config.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  static String route = 'home';
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final token = Provider.of<UserServices>(context).token;
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimeryColor,
        onPressed: () {
          print(token);
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
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //
            appbar(),
            //

            bodyPart(),
            //
          ],
        ),
      ),
    );
  }

  Widget appbar() {
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
                  text: 'Winston',
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
    return Container(
      height: getPSH(130),
      width: getPSW(305),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            spreadRadius: 0,
            offset: Offset(0, 1),
            blurRadius: 9.0,
            color: Colors.grey[350])
      ], borderRadius: BorderRadius.circular(getPSH(20)), color: kLightBlueC),
      child: Align(
          child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
            text:
                'Aun no tienes centros de belleza registrados puedes agregar tocando el ',
            style: TextStyle(color: kLightColor, fontSize: getPSH(18)),
          ),
          TextSpan(
            text: 'boton de agregar abajo',
            style: TextStyle(color: Colors.black, fontSize: getPSH(18)),
          ),
        ]),
      )),
    );
  }
}
