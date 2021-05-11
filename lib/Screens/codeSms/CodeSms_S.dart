import 'package:bp/Components/customButton.dart';
import 'package:bp/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class SmsPage extends StatefulWidget {
  SmsPage({Key key}) : super(key: key);

  static String route = 'sms';
  @override
  _SmsPageState createState() => _SmsPageState();
}

final BoxDecoration pinPutDecoration = BoxDecoration(
  color: const Color.fromRGBO(43, 46, 66, 1),
  borderRadius: BorderRadius.circular(10.0),
  border: Border.all(
    color: const Color.fromRGBO(126, 203, 224, 1),
  ),
);

class _SmsPageState extends State<SmsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppBarr(
            context: context,
            text: 'Verifica tu codigo',
            text1: 'Asegurate de escribirlo correcto',
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              // CustomButton(text: 'text', context: context, pressd: () {}),
              inputCode(),
              TextButton(
                  onPressed: () {},
                  child: Container(
                      height: 50,
                      width: 400,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: kSecundary),
                      child: Center(
                          child: Text(
                        'probando',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      )))),
            ]),
          )
        ],
      ),
    );
  }

  Widget inputCode() {
    return Container(
      padding: EdgeInsets.all(40.0),
      child: PinPut(
        fieldsCount: 6,
        textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
        eachFieldWidth: 40.0,
        eachFieldHeight: 55.0,
        focusNode: FocusNode(),
        // controller: _smsControler,
        submittedFieldDecoration: pinPutDecoration,
        selectedFieldDecoration: pinPutDecoration,
        followingFieldDecoration: pinPutDecoration,
        pinAnimationType: PinAnimationType.fade,
      ),
    );
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
                  fontSize: 22)),
          Text(text1, style: TextStyle(color: Colors.grey[600], fontSize: 15))
        ]));
  }
}
