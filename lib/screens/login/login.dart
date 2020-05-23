import 'package:aptus/screens/login/login_form.dart';
import 'package:aptus/screens/sign_up/Sign_up.dart';
import 'package:flutter/material.dart';
import 'package:aptus/screens/home.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:aptus/services/components.dart';
import 'package:aptus/services/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Todo use the provider to log in, this way works but this is not the efficient way to do it!

class LoginScreen extends StatefulWidget {
  static const String id = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

String _email;
String _password;
bool showSpinner = false;

void _login () {}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
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
                      height: 20.0,
                    ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                        child: SizedBox(
                          height: 20.0,
                        ),
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          _email = value;
                        },
                        controller: _emailController,
                        decoration: kTextFieldDecoration.copyWith(
                            icon: Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            hintText: 'Email'),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          _password = value;
                        },
                        controller: _passwordController,
                        decoration: kTextFieldDecoration.copyWith(
                            icon: Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                            hintText: 'Password'),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Container(
                        child: OurRoundedButtonLarge(

                          title: 'Login',
                          colour: Color(0xFF542581),


                          onPressed:() async{
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              final user =
                              await _auth.signInWithEmailAndPassword(
                                  email: _email, password: _password);
                              if (user != null) {
                                Navigator.pushNamed(context, Home.id);
                              }
                              setState(() {
                                showSpinner = false;
                              });
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                      ),
                      FlatButton(
                        //this need to be bold or bigger
                        child: Text("Don't have an account? Sign up here",style:
                        TextStyle(fontFamily: 'DM Sans',
                            fontWeight: FontWeight.bold),),
                        textColor: Colors.white,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {
                          Navigator.pushNamed(context, SignUpScreen.id);
                        },
                      ),
                    ],
                  ),
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
