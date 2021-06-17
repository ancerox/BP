import 'package:bp/user_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'Screens/HomePage/Home_page.dart';
import 'Screens/Splash/splash_S.dart';

class AuthWraped extends StatelessWidget {
  static String route = 'authWraped';

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final prefs = UserPreferences();

    prefs.userId = user.uid;

    if (user != null) {
      return HomePage();
    } else {
      return SplashScreen();
    }
  }
}
