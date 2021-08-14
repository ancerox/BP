import 'package:bp/Components/Hour.dart';
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
    String stylistId = ModalRoute.of(context).settings.arguments;
    final apoiments = Provider.of<CenterProivder>(context).apoiments(stylistId);

//  StylistData provider = Provider.of<CenterProivder>(context).stylitys(modalRoute);

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
              appbar(context, 'Servicios en lista de', 'nombre'),
              //
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
                  child: Text(
                'Abierto de 8:00 Am a 7:50 Pm ',
                style: TextStyle(
                    fontSize: getPSH(17), fontWeight: FontWeight.w500),
              )),
              SizedBox(height: getPSH(20)),
              Expanded(
                child: TabBarView(
                    controller: _controller,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ...List.generate(
                          7,
                          (index) => day == index
                              ? DayDateBuilder(stream: apoiments, day: day)
                              : Container())
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

  dayDateBuilder(String stylistId, apoiments) {
    print('Is repeate?');

    return Container();
  }
}
/*   */

class DayDateBuilder extends StatefulWidget {
  final stream;
  final day;

  const DayDateBuilder({Key key, @required this.stream, @required this.day})
      : super(key: key);

  @override
  _DayDateBuilderState createState() => _DayDateBuilderState();
}

class _DayDateBuilderState extends State<DayDateBuilder>
    with AutomaticKeepAliveClientMixin<DayDateBuilder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder(
        stream: widget.stream,
        builder: (context, snap) {
          if (snap.data != null) {
            return ListView.builder(
                itemCount: snap.data.docs.length,
                itemBuilder: (context, index) {
                  final date = snap.data.docs[index]['hour'];
                  DateTime dateTime = date.toDate();

                  final dateDay =
                      DateTime.now().add(Duration(days: widget.day));

                  print(dateDay.hour);

                  final hora = DateFormat('h:mma').format(dateTime);
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: getPSW(20)),
                    child: dateDay.day == dateTime.day &&
                            dateTime.hour >= dateDay.hour
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Hour(
                                hour: '$hora',
                              ),
                              Spacer(),
                              Container(
                                width: getPSW(230),
                                height: getPSH(55),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(getPSW(10)),
                                    color: kSecundary),
                                child: Center(
                                  child: Text(
                                    'Ocupado',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: getPSW(16),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        : Container(),
                  );
                });
          } else {
            return LoadingWidget();
          }
        });
  }

  @override
  bool get wantKeepAlive => true;
}
