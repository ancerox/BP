import 'package:bp/Components/CustomImput.dart';
import 'package:bp/Components/customButton.dart';
import 'package:bp/Screens/Register/Register_P.dart';
import 'package:bp/Screens/codeSms/CodeSms_S.dart';
import 'package:bp/services/user_services.dart';
import 'package:bp/user_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bp/colors.dart';
import 'package:bp/size_config.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  static String routeName = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

GlobalKey<FormState> _formKey = GlobalKey<FormState>();
TextEditingController _phoneCtroller = TextEditingController(text: '+1');

bool errorText = false;

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    UserPreferences().ultimaPagina = LoginPage.routeName;
    SizeConfig().init(context);

    final provider = Provider.of<UserServices>(context);

    return provider.smsScreen
        ? SmsPage()
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'Ingresa a tu Cuenta',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
            body: body(),
          );
  }

  Widget body() {
    return SizedBox(
      width: double.infinity,
      child: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getPSW(20)),
        child: Column(
          children: [
            SizedBox(height: SizeConfig.screenHeight * 0.01),
            Text(
              'Ingresa tu numero de telefono',
              style:
                  TextStyle(fontSize: getPSW(22), fontWeight: FontWeight.bold),
            ),
            Text(
              'Inicia Seccion con tu numero telefonico ',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.03),
            Form(
              key: _formKey,
              child: customImput(
                textController: _phoneCtroller,
                onChanged: (value) {
                  if (value.length > 0) {
                    setState(() {
                      errorText = false;
                    });
                  }
                },
                validator: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      errorText = true;
                    });
                    return '';
                  }
                },
                isPassword: false,
                hintText: 'Numero Telefonico',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
            ),
            errorText
                ? Row(children: [
                    Icon(Icons.error, color: kSecundary),
                    SizedBox(
                      width: getPSW(8),
                    ),
                    Text('Ingrese un numero telefonico')
                  ])
                : Container(),
            CustomButton(
                text: 'Ingresar',
                context: context,
                pressd: () {
                  if (_formKey.currentState.validate()) {
                    verifier();
                  }
                }),
          ],
        ),
      )),
    );
  }

  verifier() async {
    final prefs = UserPreferences();

    prefs.userPhone = _phoneCtroller.text;
    final provider = Provider.of<UserServices>(context, listen: false);

//Show SnackBar if PhoneVerify is not valid
    setState(() {
      provider.verifyContext = context;
    });
    //verify phoneNum
    await provider.verifyPhone(_phoneCtroller.text);
  }
}
