import 'package:aptus/screens/sign_up/Sign_up.dart';
import 'package:aptus/services/components.dart';
import 'package:aptus/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aptus/services/current_user_auth.dart';
import 'package:aptus/screens/root.dart';

enum LoginType {
  email,
  Registration //Must be create.
}

class OurLoginForm extends StatefulWidget {
  @override
  _OurLoginFormState createState() => _OurLoginFormState();
}

class _OurLoginFormState extends State<OurLoginForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _loginUser({
    @required LoginType type,
    String email,
    String password,
    BuildContext context,
  }) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    try {
      String _returnString;

      switch (type) {
        case LoginType.email:
          _returnString =
              await _currentUser.loginUserWithEmail(email, password);
          break;
        default:
      }

      if (_returnString == "success") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => OurRoot(),
          ),
          (route) => false,
        );
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(_returnString),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
            child: SizedBox(
              height: 20.0,
            ),
          ),
          TextFormField(
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


              onPressed: () {
                _loginUser(
                    type: LoginType.email,
                    email: _emailController.text,
                    password: _passwordController.text,
                    context: context);
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
    );
  }
}
