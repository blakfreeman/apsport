import 'package:flutter/material.dart';
import 'package:aptus/services/components.dart';
import 'package:aptus/services/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:aptus/screens/home2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:aptus/services/liste.dart';
import 'package:aptus/users/users.dart';
import 'dart:async';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
  final usersRef = Firestore.instance.collection('user');

  bool showSpinner = false;
  String email;
  String password;
  String username;
  String level;
  String motivation;
  String sport;
  User currentUser;

  bool isAuth = false;

  Future<void> getUserDoc() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Firestore _fireStore = Firestore.instance;

    FirebaseUser user = await _auth.currentUser();
    DocumentReference ref = _fireStore.collection('users').document(user.uid);
    return ref.setData({
      'id': user.uid,
      "username": _username,
      "email": _email,
      "bio": _controllerMyReason,
      "timestamp": timestamp
    });
  }

  //test to be deleted later
  void createRecord() async {
    await databaseReference.collection("user").document("1").setData({
      'title': 'Mastering Flutter',
      'description': 'Programming Guide for Dart'
    });
  }

  createUserInFireStore() async {
    // 1) check if user exists in users collection in database (according to their id)
    FirebaseUser user = await _auth.currentUser();
    DocumentSnapshot doc = await usersRef.document(user.uid).get();

    if (!doc.exists) {
      // 2) if the user doesn't exist, then we want to take them to the create account page

      // 3) get username from create account, use it to make new user document in users collection
      usersRef.document(user.uid).setData({
        'id': user.uid,
        "username": _username,
        "email": _email,
        "bio": _controllerMyReason,
        "timestamp": timestamp
      });
      // make new user their own follower (to include their posts in their timeline)

      doc = await usersRef.document(user.uid).get();
    }

    currentUser = User.fromDocument(doc);
  }

  submit() async {
    try {
      final form = _formKey.currentState;
      if (form.validate()) {
        form.save();
      } else {
        return RegistrationScreen();
      }
      setState(() {
        showSpinner = true;
      });
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(email + password);

      if (newUser != null) {
        setState(() {
          createUserInFireStore();
        });
        SnackBar snackBar = SnackBar(content: Text("Welcome $username!"));
        _scaffoldKey.currentState.showSnackBar(snackBar);
        Timer(Duration(seconds: 2), () {
          Navigator.pushNamed(context, Home2.id);
        });
      }

      setState(() {
        showSpinner = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      backgroundColor: Color(0xFF542581),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  'assets/images/Aptus_white.png',
                  height: 55.0,
                ),
              ),
              Container(
                padding: EdgeInsets.all(35.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'APTUS ',
                      style: TextStyle(
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.bold,
                          fontSize: 50.0,
                          color: Colors.white),
                    ),
                    Text(
                      '                         CONNECT YOU ',
                      style: TextStyle(
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _email,
                            validator: (val) {
                              if (val.isEmpty) return 'Empty';
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.emailAddress,
                            textAlign: TextAlign.left,
                            onSaved: (val) => email = val,
                            onChanged: (value) {
                              email = value;
                            }, //TODO reajouter un message d'erreur concernant ce chant
                            decoration: kTextFieldDecoration.copyWith(
                                icon: Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                                hintText: 'Enter your email'),
                          ),
                          TextFormField(
                            controller: _pass,
                            validator: (val) {
                              if (val.trim().length < 4 || val.isEmpty) {
                                return "Password too short";
                              } else if (val.trim().length > 12) {
                                return "Password too long";
                              } else {
                                return null;
                              }
                            },
                            style: TextStyle(color: Colors.white),
                            obscureText: true,
                            textAlign: TextAlign.left,
                            onSaved: (val) => password = val,
                            onChanged: (value) {
                              password = value;
                            },
                            decoration: kTextFieldDecoration.copyWith(
                                icon: Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                ),
                                hintText: 'Password'),
                          ),
                          TextFormField(
                            controller: _username,
                            validator: (val) {
                              if (val.trim().length < 3 || val.isEmpty) {
                                return "Username too short";
                              } else if (val.trim().length > 12) {
                                return "Username too long";
                              } else {
                                return null;
                              }
                            },
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.left,
                            onSaved: (val) => username = val,
                            decoration: kTextFieldDecoration.copyWith(
                                icon: Icon(
                                  Icons.person_outline,
                                  color: Colors.black,
                                ),
                                hintText: 'Username'),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      PopupMenuButton<String>(
                                        child: TextFormField(
                                          validator: (val) {
                                            if (val.isEmpty) {
                                              return 'Select your sport';
                                            } else {
                                              return null;
                                            }
                                          },
                                          enabled: false,
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.right,
                                          controller: _controller,
                                          onSaved: (val) => sport = val,
                                          decoration:
                                              kTextFieldDecoration.copyWith(
                                                  icon: Icon(
                                                    Icons.fitness_center,
                                                    color: Colors.black,
                                                  ),
                                                  hintText: 'Choisi Ton sport'),
                                        ),
                                        onSelected: (String value) {
                                          _controller.text = value;
                                        },
                                        itemBuilder: (BuildContext context) {
                                          return Sport()
                                              .sport
                                              .map<PopupMenuItem<String>>(
                                                  (String value) {
                                            return new PopupMenuItem(
                                                child: new Text(value),
                                                value: value);
                                          }).toList();
                                        },
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 40.0),
                                        child: Divider(
                                          color: Colors.white,
                                          thickness: 2.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      PopupMenuButton<String>(
                                        child: TextFormField(
                                          validator: (val) {
                                            if (val.isEmpty) {
                                              return 'Select your Level';
                                            } else {
                                              return null;
                                            }
                                          },
                                          enabled: false,
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center,
                                          onSaved: (val) => level = val,
                                          controller: _controllerLevel,
                                          decoration:
                                              kTextFieldDecoration.copyWith(
                                                  icon: Icon(
                                                    Icons.star_half,
                                                    color: Colors.black,
                                                  ),
                                                  hintText: 'Level Sportif'),
                                        ),
                                        onSelected: (String value) {
                                          _controllerLevel.text = value;
                                        },
                                        itemBuilder: (BuildContext context) {
                                          return SportLevel()
                                              .level
                                              .map<PopupMenuItem<String>>(
                                                  (String value) {
                                            return PopupMenuItem(
                                                child: Text(value),
                                                value: value);
                                          }).toList();
                                        },
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 40.0),
                                        child: Divider(
                                          color: Colors.white,
                                          thickness: 2.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          PopupMenuButton<String>(
                            child: TextFormField(
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Select your Motivation';
                                } else {
                                  return null;
                                }
                              },
                              enabled: false,
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.left,
                              controller: _controllerMyReason,
                              onSaved: (val) => motivation = val,
                              decoration: kTextFieldDecoration.copyWith(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 10.0,
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.insert_emoticon,
                                    color: Colors.black,
                                  ),
                                  hintText: 'Motivation  sportif'),
                            ),
                            onSelected: (String value) {
                              _controllerMyReason.text = value;
                            },
                            itemBuilder: (BuildContext context) {
                              return MyReason()
                                  .best
                                  .map<PopupMenuItem<String>>((String value) {
                                return PopupMenuItem(
                                    child: Text(value), value: value);
                              }).toList();
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RoundedButtonLarge(
                          title: 'Register',
                          colour: Colors.blueAccent,
                          onPressed: createUserInFireStore,
                        ),
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
