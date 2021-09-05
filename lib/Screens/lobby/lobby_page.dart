import 'package:bp/Components/BackButton.dart';
import 'package:bp/Components/appbar.dart';
import 'package:bp/Components/loadingWidget.dart';
import 'package:bp/Screens/HomePage/Home_page.dart';
import 'package:bp/colors.dart';
import 'package:bp/models/user_models.dart';
import 'package:bp/services/centers_services.dart';
import 'package:bp/services/user_services.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
    final centerprovider = Provider.of<CenterProivder>(context);
    final userProvider = Provider.of<UserServices>(context);
    Intl.defaultLocale = 'es';

    return StreamBuilder<UserData>(
        stream: userProvider.userData,
        builder: (context, snapshot) {
          if (snapshot != null) {
            String stylistId = snapshot.data.stylistIdCurrentApoiment;
            return StreamBuilder(
                stream: centerprovider.currentApoiment(stylistId),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    final data = snapshot.data.docs[0];

                    DateTime startAt = data['hour'].toDate();
                    // DateTime finishAt = data['finishAt'].toDate();

                    final minutes =
                        startAt.difference(DateTime.now()).inMinutes;

                    return Scaffold(
                      body: SafeArea(
                        child: Column(
                          children: [
                            SizedBox(
                              height: getPSH(50),
                            ),
                            // Expanded(
                            //   flex: 2,
                            //   child: Row(
                            //     children: [
                            //       // CustomBackButton(
                            //       //   pressd: () {
                            //       //     Navigator.pushNamed(
                            //       //         context, HomePage.route);
                            //       //   },
                            //       // ),
                            //       // SizedBox(
                            //       //   width: getPSW(35),
                            //       // ),
                            //       // minutes <= 10
                            //       //     ? CircularCountDownTimer(
                            //       //         // hora: '9:00AM',
                            //       //         duration: minutes * 60,
                            //       //         initialDuration: 0,
                            //       //         controller: CountDownController(),
                            //       //         width: MediaQuery.of(context)
                            //       //                 .size
                            //       //                 .width /
                            //       //             1.8,
                            //       //         height: MediaQuery.of(context)
                            //       //                 .size
                            //       //                 .height /
                            //       //             2,
                            //       //         ringColor: Colors.grey[300],
                            //       //         ringGradient: null,
                            //       //         fillColor: kSecundary,
                            //       //         fillGradient: null,
                            //       //         backgroundColor: Colors.white,
                            //       //         backgroundGradient: null,
                            //       //         strokeWidth: 15.0,
                            //       //         strokeCap: StrokeCap.round,
                            //       //         textStyle: TextStyle(
                            //       //             fontSize: 33.0,
                            //       //             color: Colors.black,
                            //       //             fontWeight: FontWeight.bold),
                            //       //         textFormat:
                            //       //             CountdownTextFormat.HH_MM_SS,
                            //       //         isReverse: true,
                            //       //         isReverseAnimation: false,
                            //       //         isTimerTextShown: true,
                            //       //         autoStart: true,
                            //       //         onStart: () {
                            //       //           print('Countdown Started');
                            //       //         },
                            //       //         onComplete: () {
                            //       //           print('Countdown Ended');
                            //       //         },
                            //       //       )
                            //       //     : Container(
                            //       //         height: getPSH(50),
                            //       //         width: getPSW(200),
                            //       //         decoration: BoxDecoration(
                            //       //           boxShadow: [
                            //       //             BoxShadow(
                            //       //               color: Colors.grey
                            //       //                   .withOpacity(0.2),
                            //       //               spreadRadius: 5,
                            //       //               blurRadius: 6,
                            //       //               offset: Offset(0,
                            //       //                   3), // changes position of shadow
                            //       //             ),
                            //       //           ],
                            //       //           color: Colors.white,
                            //       //           borderRadius:
                            //       //               BorderRadius.circular(15),
                            //       //         ),
                            //       //         child: Center(child: Text('Hola')))
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: getPSH(50),
                            // ),
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
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // padding: EdgeInsets.all(),
                                        margin: EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Agendado para',
                                                  style: TextStyle(
                                                      color: kLightColor,
                                                      fontSize: 18),
                                                ),
                                                Text(
                                                  '${DateFormat('EEEE,dd').format(data['hour'].toDate())}',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: getPSH(10)),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${data['service']}',
                                                  style: TextStyle(
                                                      color: kLightColor,
                                                      fontSize: 18),
                                                ),
                                                Text(
                                                  '${data['price']} DOP',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Tiempo estimado',
                                                  style: TextStyle(
                                                      color: kLightColor,
                                                      fontSize: 18),
                                                ),
                                                Text(
                                                  '${data['timeInMinutes']} Mn',
                                                  // '${serviceData['timeInMinutes']} Mn',
                                                  style:
                                                      TextStyle(fontSize: 18),
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Hora de llegada',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                Text(
                                                  '${data['hour'] == null ? DateFormat('h:mma').format(DateTime.now()) : DateFormat('h:mma').format(data['hour'].toDate())},',
                                                  style:
                                                      TextStyle(fontSize: 18),
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
                                style: TextStyle(
                                    height: 1.5, fontSize: getPSH(18)),
                              ),
                            )),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                      onPressed: () {},
                                      child: Container(
                                          child: Center(
                                              child: Text(
                                            'Cancelar Servicio',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          )),
                                          height: 50,
                                          width: 210,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                              color: kSecundary))),
                                  TextButton(
                                      onPressed: () {},
                                      child: Container(
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  'Chat',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Icon(Icons.chat_rounded,
                                                    color: Colors.white),
                                              ],
                                            ),
                                          ),
                                          height: 50,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                              color: kPrimeryColor))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Scaffold(
                      body: Center(
                        child: LoadingWidget(),
                      ),
                    );
                  }
                });
          } else {
            return Scaffold(
                body: Center(
              child: LoadingWidget(),
            ));
          }
        });
  }
}
