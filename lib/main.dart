import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bp/services/centers_services.dart';
import 'package:bp/services/user_services.dart';

import 'package:flutter/services.dart';
import 'package:bp/routes.dart';
import 'package:bp/theme.dart';
import 'package:bp/user_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:showcaseview/showcaseview.dart';

import 'authWrapped.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPreferences();
  await prefs.initPrefs();

  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CenterProivder(),
        ),
        ChangeNotifierProvider(
          create: (_) => new UserServices(),
        )
      ],
      child: MaterialApp(
          localizationsDelegates: [
            // ... delegado[s] de localización específicos de la app aquí
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en'), // Inglés
            const Locale('es'), // Español
            const Locale.fromSubtags(
                languageCode:
                    'zh'), // Chino *Mira Localizaciones avanzadas más abajo*
            // ... otras regiones que la app soporte
          ],
          routes: routes,
          debugShowCheckedModeBanner: false,
          theme: themedata(),
          title: 'Material App',
          // initialRoute: 'authWraped',
          home: ShowCaseWidget(
              builder: Builder(
            builder: (_) => AuthWraped(),
          ))),
    );
  }
}
