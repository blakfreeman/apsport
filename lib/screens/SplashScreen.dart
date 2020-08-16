import 'package:flutter/material.dart';

class OurSplashScreen extends StatelessWidget {
  static const String id = 'OurSplashScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Splash.png"),
          ),
        ),
      ),
    );
  }
}
