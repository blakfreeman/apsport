import 'dart:ui';

import 'package:aptus/screens/sign_up/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:aptus/services/components.dart';
import 'package:aptus/services/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:aptus/screens/home2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:aptus/services/sport_list.dart';
import 'package:aptus/users/users.dart';
import 'dart:async';

class SignUpScreen extends StatefulWidget {
  static const String id = 'signup';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controllerLevel = TextEditingController();
  final TextEditingController _controllerMyReason = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.35), BlendMode.dstATop),
              image: AssetImage('assets/images/sign_up.jpg'),
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
                      'Profile',
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
                        Text(
                          'Add your details ',
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
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
