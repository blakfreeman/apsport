import 'package:aptus/services/components.dart';
import 'package:aptus/services/constants.dart';
import 'package:aptus/services/current_user_auth.dart';
import 'package:aptus/services/list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'file:///C:/Users/blakf/Desktop/Proto/aptus/lib/screens/player/home.dart';

class OurSignUpForm extends StatefulWidget {


  @override
  _OurSignUpFormState createState() => _OurSignUpFormState();
}

final TextEditingController _usernameController = TextEditingController();
final TextEditingController _agesController = TextEditingController();
final TextEditingController _cityController = TextEditingController();
final TextEditingController   _sportController
= TextEditingController();
final TextEditingController _sexController = TextEditingController();
final TextEditingController _levelController = TextEditingController();
final TextEditingController   _momentController
= TextEditingController();
final TextEditingController   _weeklyController
= TextEditingController();
final TextEditingController _myReasonController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passController = TextEditingController();
final TextEditingController _confirmPassController = TextEditingController();


void _signUpUser(String email, String password, BuildContext context,
    String username,String age, String gender, String city, String sport, String level,String moment,String weekly ,String motivation) async {
  CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

  try {
    String _returnString = await _currentUser.signUpUser(username,
        email,password,age,gender,city,sport,level,moment,weekly,motivation);
    if (_returnString == "success") {
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Home()));

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
              SizedBox(
                height: 70.0,
              ),
              Row(children: <Widget>[
                Expanded(
                  child: PopupMenuButton<String>(
                    child: TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Select your sex';
                        } else {
                          return null;
                        }
                      },
                      enabled: false,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.left,
                      controller: _sexController,
                      decoration: kTextFieldDecoration.copyWith(
                          icon: Icon(
                            Icons.perm_identity,
                            color: Colors.grey,
                          ),
                          hintText: 'Gender ?'),
                    ),
                    onSelected: (String value) {
                      _sexController.text = value;
                    },
                    itemBuilder: (BuildContext context) {
                      return Gender()
                          .sex
                          .map<PopupMenuItem<String>>((String value) {
                        return new PopupMenuItem(
                            child: new Text(value), value: value);
                      }).toList();
                    },
                  ),
                ),
                Expanded(
                  child: PopupMenuButton<String>(
                    child: TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Select your ages';
                        } else {
                          return null;
                        }
                      },
                      enabled: false,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.left,
                      controller: _agesController,
                      decoration: kTextFieldDecoration.copyWith(
                          icon: Icon(
                            Icons.fitness_center,
                            color: Colors.grey,
                          ),
                          hintText: 'Your age ?'),
                    ),
                    onSelected: (String value) {
                      _agesController.text = value;
                    },
                    itemBuilder: (BuildContext context) {
                      return Ages()
                          .numbers
                          .map<PopupMenuItem<String>>((String value) {
                        return new PopupMenuItem(
                            child: new Text(value), value: value);
                      }).toList();
                    },
                  ),
                ),

              ],),
              SizedBox(
                height: 5.0,
              ),
              Row(children: <Widget>[
                Expanded(
                  child:  PopupMenuButton<String>(
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
                      controller: _cityController,
                      decoration: kTextFieldDecoration.copyWith(
                          icon: Icon(
                            Icons.location_city,
                            color: Colors.grey,
                          ),
                          hintText: 'Your city ?'),
                    ),
                    onSelected: (String value) {
                      _cityController.text = value;
                    },
                    itemBuilder: (BuildContext context) {
                      return City()
                          .city
                          .map<PopupMenuItem<String>>((String value) {
                        return new PopupMenuItem(
                            child: new Text(value), value: value);
                      }).toList();
                    },
                  ),
                ),
                Expanded(
                  child:PopupMenuButton<String>(
                    child: TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return ' Please select your sport';
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
                          hintText: ' Your Favorite Sport ?'),
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
                ),

              ],),
              SizedBox(
                height: 5.0,
              ),
              Row(children: <Widget>[
                Expanded(
                  child:  PopupMenuButton<String>(
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
                          hintText: 'Your Level ?'),
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
                ),
                Expanded(
                  child:PopupMenuButton<String>(
                    child: TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'make a selection please';
                        } else {
                          return null;
                        }
                      },
                      enabled: false,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.left,
                      controller: _momentController,
                      decoration: kTextFieldDecoration.copyWith(
                          icon: Icon(
                            Icons.timer,
                            color: Colors.grey,
                          ),
                          hintText: 'Best time to play ?'),
                    ),
                    onSelected: (String value) {
                      _momentController.text = value;
                    },
                    itemBuilder: (BuildContext context) {
                      return Moment()
                          .best
                          .map<PopupMenuItem<String>>((String value) {
                        return PopupMenuItem(child: Text(value), value: value);
                      }).toList();
                    },
                  ),
                ),

              ],),
              SizedBox(
                height: 5.0,
              ),
              Row(children: <Widget>[
                Expanded(
                  child:  PopupMenuButton<String>(
                    child: TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'make a selection please';
                        } else {
                          return null;
                        }
                      },
                      enabled: false,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.left,
                      controller: _weeklyController,
                      decoration: kTextFieldDecoration.copyWith(
                          icon: Icon(
                            Icons.timeline,
                            color: Colors.grey,
                          ),
                          hintText: 'Week or Weekend ?'),
                    ),
                    onSelected: (String value) {
                      _weeklyController.text = value;
                    },
                    itemBuilder: (BuildContext context) {
                      return WeekOrWeekEnd()
                          .best
                          .map<PopupMenuItem<String>>((String value) {
                        return PopupMenuItem(child: Text(value), value: value);
                      }).toList();
                    },
                  ),
                ),
                Expanded(
                  child: PopupMenuButton<String>(
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
                          hintText: 'Your Motivation ?'),
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
                ),
              ],),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'APTUS ',
            style: TextStyle(
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                color: Colors.white),
          ),
          SizedBox(
            height: 8.0,
          ),
          GestureDetector(
            onTap: () {

    },
            child: Text(
              'Already have an account? ',
              style: TextStyle(
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              OurRoundedButtonLarge(
                title: 'Meet and play',
                colour: Colors.blueAccent,
                onPressed: () {
                  if (_passController.text == _confirmPassController.text) {
                    _signUpUser(
                        _emailController.text,
                        _passController.text,
                        context,
                       _usernameController.text,
                        _agesController.text,
                        _sexController.text,
                        _cityController.text,
                        _sportController.text,
                        _levelController.text,
                        _momentController.text,
                        _weeklyController.text,
                        _myReasonController.text);
                  } else {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Passwords do not match"),
                        duration: Duration(seconds: 4),
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
