import 'package:bp/Components/BackButton.dart';
import 'package:bp/colors.dart';
import 'package:bp/size_config.dart';
import 'package:flutter/material.dart';

class CenterPage extends StatefulWidget {
  CenterPage({Key key}) : super(key: key);

  @override
  _CenterPageState createState() => _CenterPageState();
}

class _CenterPageState extends State<CenterPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            decoration: BoxDecoration(
                color: kSecundary, borderRadius: BorderRadius.circular(20)),
            width: 285.0,
            height: 60.0,
            child: new RawMaterialButton(
              child: Text(
                'Solicitar Servicio',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
              onPressed: () {
                DateTime now = DateTime.now();
                print(now.hour);
              },
            )),
      ),
      body: CustomScrollView(
        slivers: [
          imageCenter(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
                margin: EdgeInsets.all(40),
                color: Colors.red,
                child: Container(
                  height: 80,
                  color: Colors.red,
                  child: Column(
                    children: [Text('te1')],
                  ),
                ))
          ])),
        ],
      ),
    );
  }

  Widget imageCenter() {
    return SliverAppBar(
      // this is where I would like to set some minimum constraint
      expandedHeight: 300,
      floating: false,
      pinned: true,
      bottom: PreferredSize(
        // Add this code
        preferredSize: Size.fromHeight(60.0), // Add this code
        child: Text(''), // Add this code
      ), // Add this code
      flexibleSpace: Container(
        padding: EdgeInsets.all(10),
        height: 340,
        width: double.infinity,
        child: Container(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: getPSH(30),
              ),
              CustomBackButton(),
              Spacer(
                flex: 4,
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(left: getPSW(20)),
                child: Text(
                  'Barbia don Juan',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: getPSW(24),
                      fontWeight: FontWeight.w700),
                ),
              )),
            ],
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(getPSH(10)),
            color: Colors.black.withOpacity(1),
            image: DecorationImage(
                image: NetworkImage(
                    'https://www.outletmandara.com/blog/wp-content/uploads/2014/06/ARSpa264113258barspa264g.jpg'),
                colorFilter: ColorFilter.mode(
                    Colors.grey.withOpacity(0.9), BlendMode.dstATop),
                fit: BoxFit.cover)),
      ),
    );
  }
}
