import 'package:bp/Components/customButton.dart';
import 'package:bp/Screens/HomePage/Home_page.dart';
import 'package:bp/Screens/Register/Register_P.dart';
import 'package:bp/colors.dart';
import 'package:bp/services/user_services.dart';
import 'package:bp/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

class SmsPage extends StatefulWidget {
  SmsPage({Key key}) : super(key: key);

  static String route = 'sms';
  @override
  _SmsPageState createState() => _SmsPageState();
}

TextEditingController _smsControler = TextEditingController();

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
                  onPressed: () async {
                    verifyUser();
                    // FirebaseAuth _auth = FirebaseAuth.instance;
                    // final provider =
                    //     Provider.of<UserServices>(context, listen: false);

                    // PhoneAuthCredential phoneAuthCredential =
                    //     PhoneAuthProvider.credential(
                    //         verificationId: provider.varId,
                    //         smsCode: _smsControler.text);

                    // _auth.signInWithCredential(phoneAuthCredential);

                    // Navigator.pushReplacementNamed(
                    //     context, RegisterPage.routeName);
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
    final _fireStore = FirebaseFirestore.instance;
    final provider = Provider.of<UserServices>(context, listen: false);

    final auth = FirebaseAuth.instance;
    final User user = auth.currentUser;

    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: provider.varId, smsCode: _smsControler.text);

    await auth.signInWithCredential(phoneAuthCredential);

    await _fireStore
        .collection('user')
        .where('cellPhone', isEqualTo: provider.phoneNum)
        .get()
        .then((value) {
      if (value.docs.length > 0) {
        Navigator.pushNamedAndRemoveUntil(
            context, HomePage.route, (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, RegisterPage.routeName, (route) => false);
        // final auth = FirebaseAuth.instance;
        // final User user = auth.currentUser;
        // final uid = user.linkWithCredential(credential);
        // print(uid);
      }
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
                  fontSize: 22)),
          Text(text1, style: TextStyle(color: Colors.grey[600], fontSize: 15))
        ]));
  }
}
