import 'package:aptus/model/users.dart';
import 'package:aptus/screens/player/home.dart';
import 'package:aptus/screens/login/login.dart';
import 'package:aptus/screens/sign_up/Sign_up.dart';
import 'package:aptus/services/helper.dart';
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

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool userIsLoggedIn;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn  = value;
      });
    });
  }

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
        initialRoute:OurRoot.id,
        routes: {
          //maybe I'll change the way we initiate the route
          OurRoot.id: (context) => OurRoot(),
          LoginScreen.id: (context) => LoginScreen(),
          Home.id: (context) => Home(),
          SignUpScreen.id: (context) => SignUpScreen(),
          MainePage.id: (context) => MainePage(),
        },
      ),
    );
  }
}
