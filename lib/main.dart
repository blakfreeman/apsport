import 'package:aptus/model/users.dart';
import 'package:aptus/screens/SplashScreen.dart';
import 'package:aptus/screens/player/home.dart';
import 'package:aptus/screens/login/login.dart';
import 'package:aptus/screens/sign_up/Sign_up.dart';
import 'screens/player/maine_page.dart';
//import 'screens/player/maine_page/maine_page.dart';
//import 'package:aptus/screens/player/near_me.dart';
import 'package:aptus/screens/root.dart';
import 'package:aptus/screens/player/search.dart';
import 'package:aptus/services/current_user_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aptus/services/data_base.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CurrentUser(),
        ),
        ChangeNotifierProvider(
          create: (context) => OurDatabase(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', "US"),
          const Locale('fr', "BE"),
        ],
        title: 'APTUS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Color(0xFF542581), accentColor: Colors.blueAccent),
        initialRoute: OurRoot.id,
        routes: {
          //maybe I'll change the way we initiate the route
          OurRoot.id: (context) => OurRoot(),
          LoginScreen.id: (context) => LoginScreen(),
          OurSplashScreen.id: (context) => OurSplashScreen(),
          Home.id: (context) => Home(),
          SignUpScreen.id: (context) => SignUpScreen(),
          MainePage.id: (context) => MainePage(),
          Search.id: (context) => Search(),
        },
      ),
    );
  }
}
