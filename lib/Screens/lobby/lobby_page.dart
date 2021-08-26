import 'package:bp/Components/appbar.dart';
import 'package:bp/colors.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';

class LobbyPage extends StatefulWidget {
  LobbyPage({Key key}) : super(key: key);

  static String route = 'lobby';

  @override
  _LobbyPageState createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // appbar(context, text: 'Tu servicio',),
            SizedBox(
              height: getPSH(20),
            ),
            Expanded(
              flex: 2,
              child: CircularCountDownTimer(
                hora: '9:00AM',
                duration: 2000,
                initialDuration: 0,
                controller: CountDownController(),
                width: MediaQuery.of(context).size.width / 1.8,
                height: MediaQuery.of(context).size.height / 2,
                ringColor: Colors.grey[300],
                ringGradient: null,
                fillColor: kSecundary,
                fillGradient: null,
                backgroundColor: Colors.white,
                backgroundGradient: null,
                strokeWidth: 15.0,
                strokeCap: StrokeCap.round,
                textStyle: TextStyle(
                    fontSize: 33.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textFormat: CountdownTextFormat.MM_SS,
                isReverse: true,
                isReverseAnimation: false,
                isTimerTextShown: true,
                autoStart: true,
                onStart: () {
                  print('Countdown Started');
                },
                onComplete: () {
                  print('Countdown Ended');
                },
              ),
            ),
            SizedBox(
              height: getPSH(50),
            ),
            Expanded(
              flex: 2,
              child: Container(
                  // height: getPSH(200),
                  margin: EdgeInsets.all(20),
                  // padding: EdgeInsets.all(20),

                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 6,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // padding: EdgeInsets.all(),
                        margin: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tu servicio',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: getPSH(16)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Corte de pelo',
                                  style: TextStyle(
                                      color: kLightColor, fontSize: 18),
                                ),
                                Text(
                                  '200',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tiempo estimado',
                                  style: TextStyle(
                                      color: kLightColor, fontSize: 18),
                                ),
                                Text(
                                  '45 Mn',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              thickness: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Hora de llegada',
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  '200',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: getPSH(20),
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Tu servicio esta en turno por favor llega 10 minutos antes de la hora acordada',
                textAlign: TextAlign.center,
                style: TextStyle(height: 1.5, fontSize: getPSH(18)),
              ),
            )),
            Expanded(
              child: Row(
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
            ),
          ],
        ),
      ),
    );
  }
}
