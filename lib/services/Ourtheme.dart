import 'package:flutter/material.dart';

class OurTheme {
  Color _laPurple = Color(0xFF542581);
  Color _laGold = Color(0xFFFDB927);
  Color _blue = Colors.blueAccent;
  Color _lightGrey = Color.fromARGB(255, 164, 164, 164);
  Color _darkerGrey = Color.fromARGB(255, 119, 124, 135);

  ThemeData buildTheme() {
    return ThemeData(
      canvasColor: _laPurple,
      primaryColor: _blue,
      accentColor: _lightGrey,
      secondaryHeaderColor: _darkerGrey,
      hintColor: _lightGrey,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
            color: _laGold,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
            color: _laGold,
          ),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: _blue,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        minWidth: 150,
        height: 40.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
