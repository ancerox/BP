import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../colors.dart';
import '../../size_config.dart';
import 'apoiment_widget.dart';
import 'dateTime_Screen.dart';

class DayDateBuilder extends StatefulWidget {
  final stream;
  final day;

  const DayDateBuilder({Key key, @required this.stream, @required this.day})
      : super(key: key);

  @override
  _DayDateBuilderState createState() => _DayDateBuilderState();
}

Future future;

List apoiments = [];

class _DayDateBuilderState extends State<DayDateBuilder>
    with AutomaticKeepAliveClientMixin<DayDateBuilder> {
  @override
  void initState() {
    super.initState();
    // future = widget.stream;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
        stream: widget.stream,
        builder: (context, AsyncSnapshot snap) {
          if (snap.connectionState == ConnectionState.done || snap.hasData) {
            DateTime now = DateTime.now().add(Duration(days: widget.day));

            apoiments.clear();

            for (var item in snap.data.docs) {
              if (item['hour'].toDate().day == now.day) {
                apoiments.add(item);
              }
              // print(DateTime.now().isAfter(item['hour'].toDate()));
              // print(item['hour'].toDate() );
              // DateTime.now().is
              print(apoiments);

              if (item['hour'].toDate().isBefore(now) &&
                      item['finishAt'].toDate().isAfter(now) ||
                  item['hour'].toDate().isAtSameMomentAs(now)) {
                return Column(
                  children: [
                    Container(
                      height: getPSH(40),
                      width: double.infinity,
                      decoration: BoxDecoration(color: kSecundary),
                      child: Center(
                        child: Text(
                          'Turno actual acaba a las ${DateFormat('h:mma').format(item['finishAt'].toDate())}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: getPSH(18),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }

            if (apoiments.isEmpty) {
              //Todo: do not show apoiments thats after hours
              return Column(
                children: [
                  Container(
                      height: getPSH(60),
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.grey[400]),
                      child: Center(
                        child: Text(
                            'Aun no hay turnos agendados para ${listOfDays[DateTime.now().add(Duration(days: widget.day)).weekday - 1].toString()}. Se el primero!',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: getPSH(13),
                                fontWeight: FontWeight.w500)),
                      )),
                ],
              );
            } else {
              return Column(children: [
                ...List.generate(apoiments.length, (index) {
                  final date = apoiments[index]['hour'];
                  DateTime dateTime = date.toDate();

                  final dateDay =
                      DateTime.now().add(Duration(days: widget.day));

                  DateTime now = DateTime.now();

                  final hora = DateFormat('h:mma').format(dateTime);

                  return Container(
                      margin: EdgeInsets.symmetric(horizontal: getPSW(20)),
                      child:
                          dateDay.day == dateTime.day && now.isBefore(dateTime)
                              ? ApoimentWidget(hora: hora)
                              : Container());
                }),
              ]);
            }
          } else {
            return Container();
          }
        });
  }

  @override
  bool get wantKeepAlive => true;
}
