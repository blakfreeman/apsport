import 'package:aptus/services/components.dart';
import 'package:aptus/services/constants.dart';
import 'package:aptus/services/current_user_auth.dart';
import 'package:aptus/services/sport_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aptus/screens/home2.dart';

class OurSignUpForm extends StatefulWidget {
  @override
  _OurSignUpFormState createState() => _OurSignUpFormState();
}

final TextEditingController _sportController = TextEditingController();
final TextEditingController _levelController = TextEditingController();
final TextEditingController _myReasonController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _usernameController = TextEditingController();
final TextEditingController _passController = TextEditingController();
final TextEditingController _confirmPassController = TextEditingController();


void _signUpUser(String email, String password, BuildContext context,
    String username, String sport, String level, String motivation) async {
  CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

  try {
    String _returnString = await _currentUser.signUpUser(
        email, password, username, sport, level, motivation);
    if (_returnString == "success") {
      Navigator.pushNamed(context, Home2.id);

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

class _OurSignUpFormState extends State<OurSignUpForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _emailController,
                //TODO rajouter un message d'erreur concernant ce chant
                decoration: kTextFieldDecoration.copyWith(
                    icon: Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                    hintText: 'Enter your email'),
              ),
              TextFormField(
                controller: _passController,
                style: TextStyle(color: Colors.white),
                obscureText: true,
                decoration: kTextFieldDecoration.copyWith(
                    icon: Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),
                    hintText: 'Password'),
              ),
              TextFormField(style: TextStyle(color: Colors.white),
                controller: _confirmPassController,
                decoration: kTextFieldDecoration.copyWith(
                  icon: Icon(
                    Icons.lock,
                    color: Colors.grey,
                  ),
                  hintText: "Confirm Password",
                ),
                obscureText: true,
              ),
              TextFormField(
                controller: _usernameController,
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
                decoration: kTextFieldDecoration.copyWith(
                    icon: Icon(
                      Icons.person_outline,
                      color: Colors.grey,
                    ),
                    hintText: 'Username'),
              ),

              //Todo  check angela todo list app for adding sport and others
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
                  textAlign: TextAlign.left,
                  controller: _sportController,
                  decoration: kTextFieldDecoration.copyWith(
                      icon: Icon(
                        Icons.fitness_center,
                        color: Colors.grey,
                      ),
                      hintText: 'Choisi Ton sport'),
                ),
                onSelected: (String value) {
                  _sportController.text = value;
                },
                itemBuilder: (BuildContext context) {
                  return Sport()
                      .sport
                      .map<PopupMenuItem<String>>((String value) {
                    return new PopupMenuItem(
                        child: new Text(value), value: value);
                  }).toList();
                },
              ),
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
                  textAlign: TextAlign.left,
                  controller: _levelController,
                  decoration: kTextFieldDecoration.copyWith(
                      icon: Icon(
                        Icons.star_half,
                        color: Colors.grey,
                      ),
                      hintText: 'Level Sportif'),
                ),
                onSelected: (String value) {
                  _levelController.text = value;
                },
                itemBuilder: (BuildContext context) {
                  return SportLevel()
                      .level
                      .map<PopupMenuItem<String>>((String value) {
                    return PopupMenuItem(child: Text(value), value: value);
                  }).toList();
                },
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
                  controller: _myReasonController,
                  // it seems that my code is wrong here
                  decoration: kTextFieldDecoration.copyWith(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 10.0,
                        ),
                      ),
                      icon: Icon(
                        Icons.insert_emoticon,
                        color: Colors.grey,
                      ),
                      hintText: 'Motivation  sportif'),
                ),
                onSelected: (String value) {
                  _myReasonController.text = value;
                },
                itemBuilder: (BuildContext context) {
                  return MyReason()
                      .reason
                      .map<PopupMenuItem<String>>((String value) {
                    return PopupMenuItem(child: Text(value), value: value);
                  }).toList();
                },
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              OurRoundedButtonLarge(
                title: 'Register',
                colour: Colors.blueAccent,
                onPressed: () {
                  if (_passController.text == _confirmPassController.text) {
                    _signUpUser(
                        _emailController.text,
                        _passController.text,
                        context,
                        _usernameController.text,
                        _sportController.text,
                        _levelController.text,
                        _myReasonController.text);
                  } else {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Passwords do not match"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
