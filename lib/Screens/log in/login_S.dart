import 'package:bp/Components/CustomImput.dart';
import 'package:bp/Components/customButton.dart';
import 'package:bp/Screens/Register/Register_P.dart';
import 'package:flutter/material.dart';
import 'package:bp/colors.dart';
import 'package:bp/size_config.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  static String routeName = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
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
              'Bienvenido de vuelta',
              style:
                  TextStyle(fontSize: getPSW(25), fontWeight: FontWeight.bold),
            ),
            Text(
              'Inicia Seccion con tu numero telefonico ',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.03),
            Form(
              // key: _formKey,
              child: customImput(
                validator: (value) {
                  if (value.isEmpty) {
                    print('no funciona');
                  }
                },
                isPassword: false,
                hintText: 'Numero Telefonico',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
            ),
            CustomButton(
                text: 'Ingresar',
                context: context,
                pressd: () {
                  if (_formKey.currentState.validate()) {
                    print('validado');
                  } else {
                    print('no se puede validar');
                  }
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Aun no tienes una cuenta?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, RegisterPage.routeName);
                  },
                  child: Text(
                    'Registrate',
                    style: TextStyle(
                        fontSize: getPSW(12),
                        fontWeight: FontWeight.bold,
                        color: kPrimeryColor),
                  ),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
