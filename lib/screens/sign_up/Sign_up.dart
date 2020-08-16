import 'package:aptus/screens/sign_up/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:aptus/users/users.dart';
import 'package:aptus/screens/sign_up/sign_up.i18n.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'sign up';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final databaseReference = Firestore.instance;
  final DateTime timestamp = DateTime.now();
  final usersRef = Firestore.instance.collection('users');
  final db = Firestore.instance;

  bool showSpinner = false;
  String email;
  String password;
  String username;
  String level;
  String motivation;
  String sport;
  User currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              image: AssetImage('assets/images/background_2.jpg'),
              fit: BoxFit.cover),
        ),
        constraints: BoxConstraints(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  BackButton(
                    color: Colors.white,
//Todo I need to find a way to put this on the top center without padding
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 130.0),
                    child: Text(
                      'Sign up'.i18n.toUpperCase(),
                      style: TextStyle(
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white),
                    ),
                  ),
// Align(
//alignment: Alignment.topCenter,
//child: Image.asset(
//'assets/images/Aptus_white.png',
//height: 55.0,
//),
// ),
                ],
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(35.0),
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
//                        SizedBox(
//                          height: 10.0,
//                        ),
                        OurSignUpForm(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
