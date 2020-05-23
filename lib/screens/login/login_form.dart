import 'package:aptus/screens/sign_up/Sign_up.dart';
import 'package:aptus/services/components.dart';
import 'package:aptus/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aptus/services/current_user_auth.dart';
import 'package:aptus/screens/root.dart';
import 'package:aptus/screens/home.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:firebase_auth/firebase_auth.dart';



//Todo use the provider to log in, this way works but this is not the efficient way to do it!

class OurLoginForm extends StatefulWidget {
  @override
  _OurLoginFormState createState() => _OurLoginFormState();
}

class _OurLoginFormState extends State<OurLoginForm> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _email;
  String _password;
  bool showSpinner = false;

  void _login () async{
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
  }



  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall:showSpinner,
      child: Container(
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


                onPressed:_login,
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
    );
  }
}
