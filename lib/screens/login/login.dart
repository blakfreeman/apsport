import 'package:aptus/screens/sign_up/Sign_up.dart';
import 'package:aptus/services/data_base.dart';
import 'package:aptus/services/helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:aptus/screens/player/home.dart';
import 'package:aptus/services/components.dart';
import 'package:aptus/services/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aptus/screens/graphics/apTextFormField.dart';
import 'package:aptus/screens/login/login.i18n.dart';
import 'package:email_validator/email_validator.dart';
import 'package:aptus/screens/graphics/apRoundedButtonLarge.dart';

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
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _LoginScreenState extends State<LoginScreen> {
  bool _userExist = false;
  checkUserValue<bool>(String user) {
    OurDatabase.doesMailAlreadyExist(user).then((val) {
      if (val) {
        print("UserName Already Exits");
        _userExist = val;
      } else {
        print("UserName is Available");
        _userExist = val;
      }
    });
    return _userExist;
  }

  void validateAndSignIn() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      print('Form is valid');
      final user =
          _auth.signInWithEmailAndPassword(email: _email, password: _password);
      if (user != null) {
        Navigator.pushNamed(context, Home.id);
      }
    } else {
      print('Form is invalid');
    }
  }

  bool userIsLoggedIn;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background_2.jpg'),
                fit: BoxFit.cover),
          ),
          constraints: BoxConstraints(),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    'assets/images/icon_new.png',
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 8.0),
                              child: SizedBox(
                                height: 20.0,
                              ),
                            ),
                            ApTextFormField(
                              onChanged: (value) {
                                _email = value;
                              },
                              validator: (email) => EmailValidator.validate(
                                      email)
                                  ? checkUserValue(email)
                                      ? null
                                      : "This email address is not registered in Aptus"
                                          .i18n
                                  : "Correct the email address format".i18n,
                              hintText: 'Email'.i18n,
                              controller: _emailController,
                              type: TextInputType.emailAddress,
                              obscureText: false,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            ApTextFormField(
                              onChanged: (value) {
                                _password = value;
                              },
                              hintText: 'Password'.i18n,
                              controller: _passwordController,
                              type: TextInputType.visiblePassword,
                              obscureText: true,
                            ),
                            SizedBox(
                              height: 40.0,
                            ),
                            Container(
                              child: ApRoundedButtonLarge(
                                title: 'Sign in'.i18n.toUpperCase(),
                                onPressed: () async {
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  try {
                                    validateAndSignIn();
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
                              child: Text.rich(
                                TextSpan(
                                  text: "Don't have an account yet? Sign up "
                                      .i18n,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'here'.i18n,
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                        )),
                                    // can add more TextSpans here...
                                  ],
                                ),
                              ),
                              textColor: Colors.white,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
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
      ),
    );
  }
}
