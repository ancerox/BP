import 'package:bp/Components/CustomImput.dart';
import 'package:bp/Components/customButton.dart';
import 'package:bp/Components/loadingWidget.dart';
import 'package:bp/Screens/HomePage/Home_page.dart';

import 'package:bp/Screens/codeSms/CodeSms_S.dart';
import 'package:bp/Screens/log%20in/login_S.dart';

import 'package:bp/services/user_services.dart';

import 'package:flutter/material.dart';
import 'package:bp/colors.dart';
import 'package:bp/size_config.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../user_preferences.dart';
import 'errosStrings.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);
  static String routeName = 'register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

bool isLoading = false;

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    UserPreferences().ultimaPagina = RegisterPage.routeName;
    SizeConfig().init(context);

    return isLoading
        ? LoadingWidget()
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'Registrate',
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.01),
              Text(
                'Crea una cuenta',
                style: TextStyle(
                    fontSize: getPSW(25), fontWeight: FontWeight.bold),
              ),
              Text(
                'Crea una cuenta con tu numero telefonico \ndonde reciviras un mensaje sms ',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              //  Inputs
              InputsRegister(),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text('Ya tienes una cuenta?'),
              //     TextButton(
              //       onPressed: () =>
              //           Navigator.pushNamed(context, LoginPage.routeName),
              //       child: Text(
              //         'Inicia Seccion',
              //         style: TextStyle(
              //             fontSize: getPSW(12),
              //             fontWeight: FontWeight.bold,
              //             color: kPrimeryColor),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      )),
    );
  }
}

class InputsRegister extends StatefulWidget {
  @override
  _InputsRegisterState createState() => _InputsRegisterState();
}

class _InputsRegisterState extends State<InputsRegister> {
  //
  List<String> errorList = [];
  //
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //
  TextEditingController repeatPassCtrl = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameCtrl = TextEditingController();

  bool terms = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          customImput(
              textController: _nameCtrl,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    errorList.remove(kNameError);
                  });
                }
              },
              validator: (value) {
                if (errorList.contains(kNameError)) {
                  return '';
                }
                if (value.isEmpty) {
                  setState(() {
                    errorList.add(kNameError);
                  });
                }
              },
              hintText: 'Nombre',
              icon: Icons.person,
              isPassword: false,
              keyboardType: TextInputType.text),
          customImput(
              // focusNode: focusnode.hasFocus,
              // textController: _emailEditingController,
              onChanged: (value) {
                if (regExp.hasMatch(value)) {
                  return setState(() {
                    errorList.remove(kErrorNoValidEmail);
                  });
                }
                if (value.isNotEmpty) {
                  return setState(() {
                    errorList.remove(kErrorEmail);
                  });
                }
              },
              validator: (value) {
                if (errorList.contains(kErrorNoValidEmail)) {
                  return '';
                }
                if (!regExp.hasMatch(value) || value.isEmpty) {
                  setState(() {
                    errorList.add(kErrorNoValidEmail);
                  });
                  return '';
                }

                return null;
              },
              textController: _emailController,
              hintText: 'Correo Electronico',
              icon: Icons.mail,
              isPassword: false,
              keyboardType: TextInputType.emailAddress),
          customImput(
              textController: repeatPassCtrl,
              onChanged: (value) {
                if (value.length >= 8) {
                  setState(() {
                    errorList.remove(kErrorPass);
                  });
                }
              },
              validator: (value) {
                if (errorList.contains(kErrorPass)) {
                  return '';
                }
                if (value.length < 8) {
                  setState(() {
                    errorList.add(kErrorPass);
                  });
                  return '';
                }
                return null;
              },
              hintText: 'Contrasena',
              icon: Icons.lock_rounded,
              isPassword: true,
              keyboardType: TextInputType.text),
          customImput(
              onChanged: (value) {
                if (value != repeatPassCtrl.text) return;
                setState(() {
                  errorList.remove(kPassMatch);
                });
              },
              validator: (value) {
                if (errorList.contains(kPassMatch)) {
                  return '';
                } else if (value != repeatPassCtrl.text) {
                  setState(() {
                    errorList.add(kPassMatch);
                  });
                  return '';
                }
                return null;
              },
              hintText: 'Repetir contrasena',
              icon: Icons.lock_rounded,
              isPassword: true,
              keyboardType: TextInputType.emailAddress),
          Row(
            children: [
              Checkbox(value: false, onChanged: (value) {}),
              Text('Acepto los terminos y condiciones'),
            ],
          ),
          Column(
            children: List.generate(errorList.length,
                (index) => textsErros(error: errorList[index])),
          ),
          CustomButton(
              text: 'Registrase',
              //
              context: context,
              pressd: () {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    isLoading = true;
                  });
                  register();
                }
              }),
        ],
      ),
    );
  }

  void register() async {
    final provider = Provider.of<UserServices>(context, listen: false);
    await provider.registerUser(
        _emailController.text, repeatPassCtrl.text, _nameCtrl.text);

    Navigator.pushReplacementNamed(context, HomePage.route);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 3),
      backgroundColor: kPrimeryColor,
      content: Text(
        'Te has Registrado correctamente',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: getPSH(16)),
      ),
    ));
  }

  Row textsErros({String error}) {
    return Row(children: [
      Icon(Icons.error, color: kSecundary),
      SizedBox(
        width: getPSW(8),
      ),
      Text(error)
    ]);
  }
}
