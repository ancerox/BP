import 'package:bp/Components/appbar.dart';
import 'package:bp/Components/customButton.dart';
import 'package:bp/colors.dart';
import 'package:bp/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServicesStylists extends StatefulWidget {
  ServicesStylists({Key key}) : super(key: key);

  @override
  _ServicesStylistsState createState() => _ServicesStylistsState();
}

class _ServicesStylistsState extends State<ServicesStylists> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              //
              Expanded(child: appbar(context, text: 'Agregar Servicio')),
              Spacer(),
              //
              // setHour(),
              //
              Expanded(flex: 4, child: servicesSt()),
              Expanded(flex: 2, child: Container()),

              CustomButton(
                  text: 'Confirmar Servicio',
                  context: context,
                  pressd: () {
                    confirmAlert();
                  })
            ],
          ),
        ),
      ),
    );
  }

  setHour() {}

  Container servicesSt() {
    return Container(
        // padding: EdgeInsets.all(20),
        height: getPSH(400),
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
              margin: EdgeInsets.all(10),
              child: Text(
                'Servicios',
                style: TextStyle(fontSize: getPSH(16)),
              ),
            ),
            Divider(
              thickness: 2,
            ),
            SizedBox(
              height: getPSH(10),
            ),
            Expanded(
                child: ListView(
              children: List.generate(
                9,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: getPSH(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pelada completa',
                        style: TextStyle(fontSize: getPSH(16)),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.add,
                          size: getPSH(23),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            )),
            Divider(
              thickness: 2,
            ),
            Container(
                margin: EdgeInsets.all(getPSH(10)),
                child: Column(
                  children: [
                    Text(
                      'Selecionados',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: getPSH(16)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Selecionados',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ))
          ],
        ));
  }

  confirmAlert() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(getPSH(30)),
            ),
            child: Container(
              height: getPSH(250),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              bottom: getPSH(10), top: getPSH(15)),
                          width: getPSW(150),
                          height: getPSH(3),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                        ),
                        Text(
                          'Estas seguro ?',
                          style: TextStyle(
                              fontSize: getPSH(17),
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: getPSH(30),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: getPSW(20)),
                          child: Text(
                            'Vas a agendar un turno con Maria \nGuzman a las 9:00 Am. Es necesario que estes 10 minutos antes de la hora acordada',
                            style: TextStyle(
                                // fontWeight: FontWeight.w600,
                                fontSize: getPSW(14)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: Container(
                                      child: Center(
                                          child: Text(
                                        'De acuerdo',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      )),
                                      height: getPSH(35),
                                      width: getPSW(150),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(9),
                                          color: kSecundary))),
                              TextButton(
                                  onPressed: () {},
                                  child: Container(
                                      child: Center(
                                        child: Text(
                                          'No ahora',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      height: getPSH(35),
                                      width: getPSW(100),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(9),
                                          color: kPrimeryColor))),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    // These values are based on trial & error method
                    alignment: Alignment(1.07, -1.08),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: getPSH(40),
                        width: getPSW(40),
                        decoration: BoxDecoration(
                          color: kPrimeryColor,
                          borderRadius: BorderRadius.circular(getPSH(20)),
                        ),
                        child: Icon(
                          Icons.close,
                          size: getPSH(30),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
