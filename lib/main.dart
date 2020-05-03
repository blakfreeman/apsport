import 'package:aptus/screens/chat.dart';
import 'package:aptus/screens/edit_profile.dart';
import 'package:aptus/screens/event.dart';
import 'package:aptus/screens/home.dart';
import 'package:aptus/screens/login_page.dart';
import 'package:aptus/screens/registration.dart';
import 'package:aptus/screens/near_me.dart';
import 'package:aptus/screens/profiles.dart';
import 'package:aptus/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:aptus/screens/home2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APTUS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xFF542581), accentColor: Colors.blueAccent),
      initialRoute: Home.id,
      routes: {
        Home.id: (context) => Home(),
        LoginPage.id: (context) => LoginPage(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        NearMe.id: (context) => NearMe(),
        Home2.id: (context) => Home2(),
      },
    );
  }
}
