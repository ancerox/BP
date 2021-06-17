import 'package:bp/Components/BackButton.dart';
import 'package:bp/Components/Hour.dart';
import 'package:bp/Components/appbar.dart';
import 'package:bp/colors.dart';
import 'package:bp/models/data_time.dart';
import 'package:bp/services/centers_services.dart';
import 'package:bp/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DateTimePage extends StatefulWidget {
  DateTimePage({Key key}) : super(key: key);

  static String route = 'dataTime';

  @override
  _DateTimePageState createState() => _DateTimePageState();
}

List<String> listOfDays = [
  "lun",
  "mar",
  "mie",
  "jue",
  "vie",
  "sab",
  "dom",
];

class _DateTimePageState extends State<DateTimePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  int day = 0;

  @override
  initState() {
    super.initState();
    _controller = TabController(length: 1, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DefaultTabController(
        initialIndex: 0,
        length: 7,
        child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {},
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
                  appbar(context, text: 'Servicios en lista'),
                  //
                  TabBar(
                    isScrollable: true,
                    indicatorColor: Colors.transparent,
                    labelPadding: EdgeInsets.all(0),
                    labelColor: Colors.black,
                    onTap: (value) {
                      setState(() {
                        day = value;
                      });
                    },
                    // isScrollable: true,
                    tabs: List.generate(
                      7,
                      (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: getPSH(5)),
                        child: days(index),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                        children: List.generate(7, (index) {
                      return dayDateBuilder();
                    })),
                  ),
                ],
              ),
            )));
  }

  Container days(int index) {
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
                      .toString(),
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
                      .toString(),
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

  dayDateBuilder() {
    String tappedDay =
        DateFormat.d().format(DateTime.now().add(Duration(days: day)));

    final stylistId = ModalRoute.of(context).settings.arguments;
    final provider = Provider.of<CenterProivder>(context, listen: false)
        .apoiments(stylistId);

    return Column(
      children: [
        ...List.generate(2, (index) {
          return StreamBuilder(
            stream: provider,
            builder: (contex, snap) {
              // print(snap.data);
              return Container();
            },
          );
        })
      ],
    );
  }
}
