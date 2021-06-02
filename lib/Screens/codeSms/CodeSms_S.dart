import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:bp/services/user_services.dart';
import 'package:bp/size_config.dart';

import 'package:bp/Components/loadingWidget.dart';
import 'package:bp/colors.dart';

import '../../user_preferences.dart';

class SmsPage extends StatefulWidget {
  SmsPage({Key key}) : super(key: key);

  @override
  _SmsPageState createState() => _SmsPageState();
  static String routeName = 'sms';
}

TextEditingController _smsControler = TextEditingController();

bool isLoading = false;

final BoxDecoration pinPutDecoration = BoxDecoration(
  color: kPrimeryColor,
  borderRadius: BorderRadius.circular(10.0),
  border: Border.all(
    color: kPrimeryColor,
  ),
);

bool isSent = true;
int timerNum = 90;
String displayNum = '';

class _SmsPageState extends State<SmsPage> {
  @override
  void initState() {
    super.initState();
    resendDendOtp();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Timer timer;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final provider = Provider.of<UserServices>(context, listen: false);

    return Scaffold(
      body: isLoading
          ? LoadingWidget()
          : CustomScrollView(
              slivers: [
                AppBarr(
                  context: context,
                  text: 'Verifica tu codigo',
                  text1: 'Resiviras un codigo al ${provider.phoneNum}',
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    // CustomButton(text: 'text', context: context, pressd: () {}),
                    inputCode(),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          verifyUser();
                        },
                        child: Container(
                            height: 50,
                            width: 400,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: kSecundary),
                            child: Center(
                                child: Text(
                              'Verificar',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            )))),
                    TextButton(
                        onPressed: isSent
                            ? null
                            : () {
                                provider.verifyPhone(provider.phoneNum);
                                setState(() {
                                  isSent = true;
                                  timerNum = 25;
                                });
                                resendDendOtp();
                              },
                        child: Text(
                          isSent
                              ? 'Podras reenviar tu codigo en $displayNum'
                              : 'Reenviar Codigo',
                          style: TextStyle(
                              fontSize: getPSH(17), color: kPrimeryColor),
                        ))
                  ]),
                )
              ],
            ),
    );
  }

  resendDendOtp() {
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        timer = t;
        timerNum = timerNum - 1;
        displayNum = timerNum.toString();
        if (timerNum <= 0) {
          t.cancel();
          isSent = false;
        }
      });
    });
  }

  Widget inputCode() {
    return Container(
      padding: EdgeInsets.all(40.0),
      child: PinPut(
        fieldsCount: 6,
        textStyle: const TextStyle(fontSize: 25, color: Colors.white),
        eachFieldWidth: getPSW(40.0),
        eachFieldHeight: getPSH(55.0),
        focusNode: FocusNode(),
        controller: _smsControler,
        submittedFieldDecoration: pinPutDecoration,
        selectedFieldDecoration: pinPutDecoration,
        followingFieldDecoration: pinPutDecoration,
        pinAnimationType: PinAnimationType.fade,
      ),
    );
  }

  verifyUser() async {
    final provider = Provider.of<UserServices>(context, listen: false);

    provider.smsCode = _smsControler.text;
    provider.smsContext = context;

    await provider.verifyUser();
    setState(() {
      isLoading = provider.isLoading;
    });
  }
}

class AppBarr extends StatelessWidget {
  const AppBarr({
    Key key,
    @required this.context,
    @required this.text,
    @required this.text1,
  }) : super(key: key);

  final BuildContext context;
  final String text;
  final String text1;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        // elevation: 9.0,
        backgroundColor: Color(0xffF8F8F8),
        title: Column(children: [
          Text(text,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff57575E),
                  fontSize: getPSH(20))),
          Text(text1,
              style: TextStyle(color: Colors.grey[600], fontSize: getPSH(15)))
        ]));
  }
}
