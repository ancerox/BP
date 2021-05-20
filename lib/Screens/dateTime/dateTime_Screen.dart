import 'package:bp/Components/BackButton.dart';
import 'package:bp/Components/Hour.dart';
import 'package:bp/colors.dart';
import 'package:bp/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DateTimePage extends StatefulWidget {
  DateTimePage({Key key}) : super(key: key);

  @override
  _DateTimePageState createState() => _DateTimePageState();
}

List<String> listOfDays = ["lun", "mar", "mie", "jue", "vie", "sab", "dom"];

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
                  appbar(),
                  //
                  TabBar(
                      isScrollable: true,
                      indicatorColor: Colors.transparent,
                      labelPadding: EdgeInsets.all(0),
                      labelColor: Colors.black,
                      onTap: (value) {
                        setState(() {
                          final now = DateTime.now();

                          // print();
                          day = value;
                        });
                      },
                      // isScrollable: true,
                      tabs: List.generate(
                          7,
                          (index) => Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: days(index),
                              ))),
                  Expanded(
                    child: TabBarView(children: [
                      Container(
                        margin: EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Hour(
                                    hour: '4:00',
                                  ),
                                  Text('1')
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(),
                      Container(),
                      Container(),
                      Container(),
                      Container(),
                      Container(),
                    ]),
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

  Widget appbar() {
    return Row(
      children: [
        CustomBackButton(),
        Spacer(),
        Text(
          'Servicios en lista',
          style: TextStyle(
              fontSize: getPSH(20),
              color: kPrimeryColor,
              fontWeight: FontWeight.w800),
        ),
        Spacer(
          flex: 2,
        ),
      ],
    );
  }
}
