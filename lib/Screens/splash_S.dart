import 'package:bp/Screens/login_S.dart';
import 'package:bp/colors.dart';
import 'package:bp/size_config.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

int currentPage = 0;
final pageController = new PageController(initialPage: 0);

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    List<Map<String, String>> splashData = [
      {
        "image": "assets/images/time.png",
        "text": "Bienvenido a BENUS. No pierdas el Tiempo",
      },
      {
        "image": "assets/images/notify.png",
        "text": "Podras ver la lista de las personas en turno",
      },
      {
        "image": "assets/images/notification.png",
        "text": "Seras notificado cada cuando se aserque tu turno",
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: PageView.builder(
                    controller: pageController,
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemCount: splashData.length,
                    itemBuilder: (context, i) => SplashContent(
                          image: splashData[i]["image"],
                          text: splashData[i]["text"],
                        ))),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          splashData.length, (index) => buildDot(index)),
                    ),
                  ],
                ),
              ),
            ),
            buttonPage()
          ],
        ),
      ),
    );
  }

  TextButton buttonPage() {
    return TextButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, LoginPage.routeName);
        },
        child: Container(
          width: 250,
          height: 40,
          decoration: BoxDecoration(
              color: kSecundary, borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              'Continuar',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }

  Container buildDot(int index) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      width: currentPage == index ? 45 : 12,
      height: 12,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: currentPage == index ? kSecundary : Colors.grey),
    );
  }
}

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.image,
    this.text,
  }) : super(
          key: key,
        );

  final String image, text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Text(
          'BENUS',
          style: TextStyle(
              color: kSecundary,
              fontSize: getPSW(36),
              fontWeight: FontWeight.bold),
        ),
        Text(
          text,
          style: TextStyle(color: kPrimeryColor),
        ),
        Image.asset(
          image,
          height: getPSH(420),
        ),
      ],
    );
  }
}
