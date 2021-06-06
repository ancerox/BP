import 'package:bp/Components/customButton.dart';
import 'package:bp/Screens/log%20in/login_S.dart';
import 'package:bp/colors.dart';
import 'package:bp/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  static String route = 'splash';

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
        "image": "assets/images/time.svg",
        "text": "Bienvenido a BENUS. No pierdas el Tiempo",
      },
      {
        "image": "assets/images/notify.svg",
        "text": "Podras ver la lista de las personas en turno",
      },
      {
        "image": "assets/images/alert.svg",
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
            CustomButton(
                text: 'Continuar',
                pressd: () {
                  Navigator.pushReplacementNamed(context, LoginPage.routeName);
                },
                context: context),
            SizedBox(height: getPSH(15))
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 8),
      width: currentPage == index ? 40 : 12,
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
          style: TextStyle(
              color: kPrimeryColor,
              fontSize: getPSW(13),
              fontWeight: FontWeight.w400),
        ),
        SvgPicture.asset(
          image,
          height: getPSH(420),
        ),
      ],
    );
  }
}
