import 'package:aptus/screens/home2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:aptus/services/components.dart';
import 'package:aptus/services/constants.dart';
import 'package:aptus/screens/registration.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aptus/users/users.dart';

class Home extends StatefulWidget {
  static const String id = 'home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final usersRef = Firestore.instance.collection('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final StorageReference storageRef = FirebaseStorage.instance.ref();
  final DateTime timestamp = DateTime.now();
  final databaseReference = Firestore.instance;

  bool _isAuth = false;
  PageController pageController;
  int pageIndex = 0;
  String email;
  String password;
  bool showSpinner = false;
  User currentUser;

  Widget buildAuthScreen() {
    return Home2();
  }

  Widget buildUnAuthScreen() {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bleu_image.png'),
                fit: BoxFit.cover),
          ),
          constraints: BoxConstraints(),
          child: SafeArea(
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
                        '                         MEET AND PLAY ',
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 90.0,
                      ),
                      TextField(
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.left,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            icon: Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            hintText: 'Enter your email'),
                      ),
                      TextField(
                        style: TextStyle(color: Colors.white),
                        obscureText: true,
                        textAlign: TextAlign.left,
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
                      Container(
                        padding: EdgeInsets.only(left: 50.0, right: 50.0),
                        child: Text(
                          "Pleas sign up if you don't have any account",
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'DM Sans'),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          RoundedButton(
                            title: 'Login',
                            colour: Color(0xFF542581),
                            onPressed: () async {
                              setState(() {
                                showSpinner = true;
                              });
                              try {
                                final user =
                                    await _auth.signInWithEmailAndPassword(
                                        email: email, password: password);
                                if (user != null) {
                                  setState(() {
                                    _isAuth = true;
                                  });
                                }

                                setState(() {
                                  showSpinner = false;
                                });
                              } catch (e) {
                                print(e);
                              }
                            },
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          RoundedButton(
                            title: 'Register',
                            colour: Colors.blueAccent,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RegistrationScreen.id);
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}

//decoration: BoxDecoration(
//gradient: LinearGradient(
//begin: Alignment.topRight,
//end: Alignment.bottomLeft,
//colors: [
//Colors.white,
//Colors.white,
//Color(0xFF542581),
//Colors.blueAccent,
// ],
//),

// backgroundColor: Colors.white,
//body: Container(
//child: Column(
//mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.stretch,
//children: <Widget>[
//SizedBox(
//height: 20.0,
//),
//Image.asset(
//'assets/images/AptusP_G.png',
//height: 90,
//),
// Text(
//'APTUS',
//textAlign: TextAlign.center,
// style: TextStyle(
// fontWeight: FontWeight.bold,
//fontFamily: 'DM Sans',
//fontSize: 25.0,
//color: Colors.black,
//),
//),
//Text(
//'                 Meet and Plays',
//textAlign: TextAlign.center,
//style: TextStyle(
//fontFamily: 'DM Sans',
//fontSize: 10.0,
//color: Colors.black,
//),
//),
//],
//),
//),
//);
