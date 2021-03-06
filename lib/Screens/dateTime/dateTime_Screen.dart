import 'dart:async';

import 'package:bp/Components/appbar.dart';
import 'package:bp/Components/loadingWidget.dart';
import 'package:bp/colors.dart';

import 'package:bp/models/stylists.dart';
import 'package:bp/services/centers_services.dart';
import 'package:bp/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'date_day_builder.dart';

class DateTimePage extends StatefulWidget {
  DateTimePage({Key key}) : super(key: key);

  static String route = 'dataTime';

  @override
  _DateTimePageState createState() => _DateTimePageState();
}

List<String> listOfDays = [
  "lunes",
  "martes",
  "miercoles",
  "jueves",
  "viernes",
  "sabado",
  "domingo",
];

class _DateTimePageState extends State<DateTimePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  Stream data;
  DateTime dateTime;
  @override
  initState() {
    super.initState();

    _controller = TabController(
      length: 7,
      vsync: this,
      initialIndex: 0,
    );
    _controller.addListener(() {
      setState(() {
        day = _controller.index;
      });
    });
  }

  int day = 0;
  @override
  Widget build(BuildContext context) {
    List stylistData = ModalRoute.of(context).settings.arguments;
    final provider = Provider.of<CenterProivder>(context);

    Stream<StylistData> stylist = provider.stylitys(stylistData[0]);

//  StylistData provider = Provider.of<CenterProivder>(context).stylitys(modalRoute);

    print(day);

    SizeConfig().init(context);
    return DefaultTabController(
      initialIndex: 0,
      length: 7,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    'stylistServices',
                    arguments: [day, stylistData[0], stylist],
                  );
                },
                child: Container(
                    child: Center(
                        child: Text(
                      'Agregar Servicio',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    )),
                    height: 50,
                    width: 210,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: kSecundary))),
            TextButton(
                onPressed: () {},
                child: Container(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Chat',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          Icon(Icons.chat_rounded, color: Colors.white),
                        ],
                      ),
                    ),
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: kPrimeryColor))),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              //
              appbar(context, 'Servicios en lista de', stylistData[1].name),
              SizedBox(
                height: getPSH(20),
              ),
              TabBar(
                controller: _controller,
                physics: NeverScrollableScrollPhysics(),
                isScrollable: true,
                indicatorColor: Colors.transparent,
                labelPadding: EdgeInsets.all(0),
                labelColor: Colors.black,
                onTap: (value) async {
                  // if (day == value) return;

                  // setState(() {
                  //   day = value;
                  // });
                },
                // isScrollable: true,
                tabs: List.generate(
                  7,
                  (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: getPSH(5)),
                      child: days(index)),
                ),
              ),
              SizedBox(height: getPSW(10)),
              Center(
                child: StreamBuilder<StylistData>(
                    stream: stylist,
                    builder: (context, snapshot) {
                      if (snapshot.hasData ||
                          snapshot.connectionState == ConnectionState.done) {
                        final openDataHour =
                            snapshot.data.availability['$day'][0].toDate();
                        final closeDataHour =
                            snapshot.data.availability['$day'][1].toDate();

                        final entrada =
                            DateFormat('h:mma').format(openDataHour);
                        final salida =
                            DateFormat('h:mma').format(closeDataHour);

                        return Text(
                          snapshot.connectionState == ConnectionState.done ||
                                  snapshot.hasData
                              ? 'Abierto desde $entrada hasta $salida'
                              : 'Los datos no han cargado',
                          style: TextStyle(
                              fontSize: getPSH(17),
                              fontWeight: FontWeight.w500),
                        );
                      } else {
                        return LoadingWidget();
                      }
                    }),
              ),
              SizedBox(height: getPSH(20)),
              // noApoimentsText(provider, stylistId),
              SizedBox(
                height: getPSH(20),
              ),
              Expanded(
                child: TabBarView(
                    controller: _controller,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ...List.generate(7, (index) {
                        dateTime = DateTime.now().add(Duration(days: day));

                        if (day == index) {
                          return DayDateBuilder(
                              stream: provider.apoiments(stylistData[0]),
                              day: day);
                        } else {
                          return Container();
                        }
                      })
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container days(int index) {
    // print(day);
    // print(index);
    return day == index
        ? Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(getPSH(25)),
                color: kPrimeryColor),
            height: getPSH(90),
            width: getPSW(53),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  listOfDays[
                          DateTime.now().add(Duration(days: index)).weekday - 1]
                      .toString()
                      .substring(0, 3),
                  style: TextStyle(
                      fontSize: getPSH(16),
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
                Text(DateTime.now().add(Duration(days: index)).day.toString(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                Icon(
                  Icons.circle,
                  color: Colors.white,
                  size: 10,
                )
              ],
            ),
          )
        : Container(
            height: 75,
            width: 45,
            margin: EdgeInsets.symmetric(horizontal: getPSW(0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  listOfDays[
                          DateTime.now().add(Duration(days: index)).weekday - 1]
                      .toString()
                      .substring(0, 3),
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffCACACA)),
                ),
                Text(DateTime.now().add(Duration(days: index)).day.toString(),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffACACAC))),
                Icon(
                  Icons.circle,
                  color: Color(0xff74EfAd),
                  size: 10,
                )
              ],
            ),
          );
  }
}
