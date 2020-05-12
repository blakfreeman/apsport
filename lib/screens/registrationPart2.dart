import 'package:aptus/screens/home2.dart';
import 'package:aptus/services/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:aptus/services/sport_list.dart';
import 'dart:async';

//this is in case wee need a full customer registration.
class RegistrationUserHabit extends StatefulWidget {
  static const String id = 'registrationPart2';
  @override
  _RegistrationUserHabitState createState() => _RegistrationUserHabitState();
}

class _RegistrationUserHabitState extends State<RegistrationUserHabit> {
  bool showSpinner = false;
  String username;
  String bioSport;
  bool isAuth = false;

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controllerLevel = TextEditingController();
  final TextEditingController _controllerCity = TextEditingController();
  final TextEditingController _controllerGenre = TextEditingController();
  final TextEditingController _controllerAges = TextEditingController();
  final TextEditingController _controllerMoment = TextEditingController();
  final TextEditingController _controllerWeekOrWeekEnd =
      TextEditingController();
  final TextEditingController _controllerMyReason = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      setState(() {});
      SnackBar snackBar = SnackBar(content: Text("Welcome $username!"));
      _scaffoldKey.currentState.showSnackBar(snackBar);
      Timer(Duration(seconds: 2), () {
        Navigator.pushNamed(context, Home2.id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFF542581),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 180.0,
                  ),
                  Text(
                    'Profil',
                    style: TextStyle(
                        fontFamily: 'DM sans',
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 105.0,
                  ),
                  Image.asset(
                    'assets/images/Aptus_white.png',
                    height: 55.0,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 0.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                TextFormField(
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
                                  textAlign: TextAlign.center,
                                  onSaved: (val) => username = val,
                                  decoration: kTextFieldDecoration.copyWith(
                                      hintText: 'Username'),
                                ),
                                Divider(
                                  color: Colors.white,
                                  thickness: 2.0,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                PopupMenuButton<String>(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Select Gender';
                                      } else {
                                        return null;
                                      }
                                    },
                                    controller: _controllerGenre,
                                    enabled: false,
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                    decoration: kTextFieldDecoration.copyWith(
                                        hintText: 'GENRE'),
                                  ),
                                  onSelected: (String value) {
                                    _controllerGenre.text = value;
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return Genre()
                                        .sex
                                        .map<PopupMenuItem<String>>(
                                            (String value) {
                                      return PopupMenuItem(
                                          child: Text(value), value: value);
                                    }).toList();
                                  },
                                ),
                                Divider(
                                  color: Colors.white,
                                  thickness: 2.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 0.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            PopupMenuButton<String>(
                              child: TextFormField(
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return 'Select Ages';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: _controllerAges,
                                enabled: false,
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                                decoration: kTextFieldDecoration.copyWith(
                                    hintText: 'Ages'),
                              ),
                              onSelected: (String value) {
                                _controllerAges.text = value;
                              },
                              itemBuilder: (BuildContext context) {
                                return Ages()
                                    .numbers
                                    .map<PopupMenuItem<String>>((String value) {
                                  return PopupMenuItem(
                                      child: Text(value), value: value);
                                }).toList();
                              },
                            ),
                            Divider(
                              color: Colors.white,
                              thickness: 2.0,
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
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Select city';
                                  } else {
                                    return null;
                                  }
                                },
                                enabled: false,
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                                controller: _controllerCity,
                                decoration: kTextFieldDecoration.copyWith(
                                    hintText: ' City'),
                              ),
                              onSelected: (String value) {
                                _controllerCity.text = value;
                              },
                              itemBuilder: (BuildContext context) {
                                return City()
                                    .city
                                    .map<PopupMenuItem<String>>((String value) {
                                  return PopupMenuItem(
                                      child: Text(value), value: value);
                                }).toList();
                              },
                            ),
                            Divider(
                              color: Colors.white,
                              thickness: 2.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 45.0, vertical: 0.0),
                child: Row(
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
                                textAlign: TextAlign.center,
                                controller: _controller,
                                decoration: kTextFieldDecoration.copyWith(
                                    hintText: 'Choisi Ton sport'),
                              ),
                              onSelected: (String value) {
                                _controller.text = value;
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
                            Divider(
                              color: Colors.white,
                              thickness: 2.0,
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
                                    return 'Select your sport';
                                  } else {
                                    return null;
                                  }
                                },
                                enabled: false,
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                                controller: _controllerLevel,
                                decoration: kTextFieldDecoration.copyWith(
                                    hintText: 'Level Sportif'),
                              ),
                              onSelected: (String value) {
                                _controllerLevel.text = value;
                              },
                              itemBuilder: (BuildContext context) {
                                return SportLevel()
                                    .level
                                    .map<PopupMenuItem<String>>((String value) {
                                  return PopupMenuItem(
                                      child: Text(value), value: value);
                                }).toList();
                              },
                            ),
                            Divider(
                              color: Colors.white,
                              thickness: 2.0,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 45.0, vertical: 0.0),
                  child: Column(
                    children: <Widget>[
                      PopupMenuButton<String>(
                        child: TextFormField(
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Select  your best moment';
                            } else {
                              return null;
                            }
                          },
                          enabled: false,
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                          controller: _controllerMoment,
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Meilleur moment'),
                        ),
                        onSelected: (String value) {
                          _controllerMoment.text = value;
                        },
                        itemBuilder: (BuildContext context) {
                          return Moment()
                              .best
                              .map<PopupMenuItem<String>>((String value) {
                            return PopupMenuItem(
                                child: Text(value), value: value);
                          }).toList();
                        },
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 2.0,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 45.0, vertical: 0.0),
                  child: Column(
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
                          textAlign: TextAlign.center,
                          controller: _controllerWeekOrWeekEnd,
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Week or Weekend'),
                        ),
                        onSelected: (String value) {
                          _controllerWeekOrWeekEnd.text = value;
                        },
                        itemBuilder: (BuildContext context) {
                          return WeekOrWeekEnd()
                              .best
                              .map<PopupMenuItem<String>>((String value) {
                            return PopupMenuItem(
                                child: Text(value), value: value);
                          }).toList();
                        },
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 2.0,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 45.0, vertical: 0.0),
                  child: Column(
                    children: <Widget>[
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
                          textAlign: TextAlign.center,
                          controller: _controllerMyReason,
                          decoration: kTextFieldDecoration.copyWith(
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
                      Divider(
                        color: Colors.white,
                        thickness: 2.0,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 45.0, vertical: 0.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (value) {
                          if (value.trim().length < 3 || value.isEmpty) {
                            return "Bio too short";
                          } else if (value.trim().length > 150) {
                            return "Bio too long";
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                        onSaved: (val) => bioSport = val,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Bio Sport'),
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 2.0,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: submit,
                child: Container(
                  height: 50.0,
                  width: 350.0,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
