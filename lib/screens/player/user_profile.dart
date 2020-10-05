import 'package:aptus/model/users.dart';
import 'package:aptus/screens/login/login.dart';
import 'package:aptus/services/current_user_auth.dart';
import 'package:aptus/services/components.dart';
import 'package:aptus/services/widget.dart';
import 'package:aptus/services/list.dart';
import 'package:aptus/services/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//add everyStep of the 1 man startup ep 47
class Profile extends StatefulWidget {
  final OurPlayer currentUser;

  const Profile({Key key, this.currentUser});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final CurrentUser _auth = CurrentUser();
  final firestoreInstance = Firestore.instance;
  TextEditingController _userUsernameController = TextEditingController();
  TextEditingController _userAgeController = TextEditingController();
  TextEditingController _userGenderController = TextEditingController();
  TextEditingController _userCityController = TextEditingController();
  TextEditingController _userSportController = TextEditingController();
  TextEditingController _userLevelController = TextEditingController();
  TextEditingController _userMomentController = TextEditingController();
  TextEditingController _userWeeklyController = TextEditingController();
  TextEditingController _userMotivationController = TextEditingController();

  OurPlayer user = OurPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: "Profile"),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: Provider.of<CurrentUser>(context).getUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return displayUserInformation(context, snapshot);
                  } else {
                    return circularProgress();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget displayUserInformation(context, snapshot) {
    return Column(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              showSignOut(context),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.black,
                  backgroundImage: AssetImage(
                      'assets/images/anthony.jpg'), //Todo to create a future builder for the user picture
                ),
              ),
              FutureBuilder(
                future: _getProfileData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    _userUsernameController.text = user.username;
                    _userAgeController.text = user.age;
                    _userGenderController.text = user.gender;
                    _userCityController.text = user.city;
                    _userSportController.text = user.sport;
                    _userLevelController.text = user.level;
                    _userMomentController.text = user.moment;
                    _userWeeklyController.text = user.weekly;
                    _userMotivationController.text = user.motivation;
                  }
                  return Container(
                    child: Column(
                      children: <Widget>[
                        OurContainer(
                          child: Column(
                            children: <Widget>[
                              Text(
                                'ID information',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'DM Sans',
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Username:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'DM Sans',
                                      ),
                                    ),
                                  ),
                                  Text(
                                    _userUsernameController.text,
                                    style: TextStyle(
                                      fontFamily: 'DM Sans',
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Age:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'DM Sans',
                                      ),
                                    ),
                                  ),
                                  Text(_userAgeController.text),
                                ],
                              ),
                              //todo is their a sense for any user to update their sex ?
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Gender:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'DM Sans',
                                      ),
                                    ),
                                  ),
                                  Text(_userGenderController.text),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'city:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'DM Sans',
                                      ),
                                    ),
                                  ),
                                  Text(_userCityController.text),
                                ],
                              ),
                              OurRoundedButton(
                                title: ("Edit ID information"),
                                colour: Colors.blueAccent,
                                onPressed: () {
                                  _userEditBottomSheetIdInfo(context);
                                },
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        OurContainer(
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Sport information',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'DM Sans',
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Sport:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'DM Sans',
                                      ),
                                    ),
                                  ),
                                  Text(_userSportController.text,
                                      style: TextStyle(
                                        fontFamily: 'DM Sans',
                                      )),
                                  SizedBox(
                                    width: 30.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Level:',
                                      style: TextStyle(
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  Text(user.level,
                                      style: TextStyle(
                                        fontFamily: 'DM Sans',
                                      )),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Best moment to play:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'DM Sans',
                                      ),
                                    ),
                                  ),
                                  Text(
                                    _userMomentController.text,
                                    style: TextStyle(
                                      fontFamily: 'DM Sans',
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Week or Week end ?:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'DM Sans',
                                      ),
                                    ),
                                  ),
                                  Text(_userWeeklyController.text),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'About me:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'DM Sans',
                                      ),
                                    ),
                                  ),
                                  Text(_userMotivationController
                                      .text), // we need to containe this text widget
                                ],
                              ),
                              OurRoundedButton(
                                title: ("Edit sport information"),
                                colour: Colors.blueAccent,
                                onPressed: () {
                                  _userEditBottomSheetSportInfo(context);
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        showSignOut(context),
      ],
    );
  }

  _getProfileData() async {
    final uid = await Provider.of<CurrentUser>(context).getCurrentUID();
    await Firestore.instance
        .collection('users')
        .document(uid)
        .get()
        .then((result) {
      user.username = result.data['username'];
      user.age = result.data['age'];
      user.gender = result.data['gender'];
      user.city = result.data['city'];
      user.sport = result.data['sport'];
      user.level = result.data['level'];
      user.moment = result.data['moment'];
      user.weekly = result.data['weekly'];
      user.motivation = result.data['motivation']; // need to find a method for all
    });
  }

  void _userEditBottomSheetIdInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * .60,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 15.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Update ID information"),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.cancel),
                      color: Colors.blueAccent,
                      iconSize: 25,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: TextField(
                    controller: _userUsernameController,
                    decoration: InputDecoration(
                      helperText: "username",
                    ),
                  ),
                ),
                Expanded(
                  child: PopupMenuButton<String>(
                    child: TextField(
                      enabled: false,
                      controller: _userAgeController,
                      decoration: InputDecoration(
                        helperText: "age",
                      ),
                    ),
                    onSelected: (String value) {
                      _userAgeController.text = value;
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
                Expanded(
                  child: PopupMenuButton<String>(
                    child: TextField(
                      enabled: false,
                      controller: _userGenderController,
                      decoration: InputDecoration(
                        helperText: "Gender",
                      ),
                    ),
                    onSelected: (String value) {
                      _userGenderController.text = value;
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
                    child: TextField(
                      enabled: false,
                      controller: _userCityController,
                      decoration: InputDecoration(
                        helperText: "City",
                      ),
                    ),
                    onSelected: (String value) {
                      _userCityController.text = value;
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Save'),
                      color: Colors.green,
                      textColor: Colors.white,
                      onPressed: () async {
                        user.username = _userUsernameController.text;
                        user.age = _userAgeController.text;
                        user.gender = _userGenderController.text;
                        user.city = _userCityController.text;

                        setState(() {
                          _userUsernameController.text = user.username;
                          _userAgeController.text = user.age;
                          _userGenderController.text = user.gender;
                          _userCityController.text = user.city;
                        });
                        var firebaseUser = await FirebaseAuth.instance
                            .currentUser(); //very important information here
                        firestoreInstance
                            .collection("users")
                            .document(firebaseUser.uid)
                            .updateData({
                          "username": _userUsernameController.text,
                          "age": _userAgeController.text,
                          'gender': _userGenderController.text,
                          'city': _userCityController.text
                        });
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _userEditBottomSheetSportInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * .60,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 15.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Update sport information"),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.cancel),
                      color: Colors.blueAccent,
                      iconSize: 25,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: PopupMenuButton<String>(
                    child: TextField(
                      enabled: false,
                      controller: _userSportController,
                      decoration: InputDecoration(
                        helperText: "Sport",
                      ),
                    ),
                    onSelected: (String value) {
                      _userSportController.text = value;
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
                Expanded(
                  child: PopupMenuButton<String>(
                    child: TextField(
                      enabled: false,
                      controller: _userLevelController,
                      decoration: InputDecoration(
                        helperText: "Age",
                      ),
                    ),
                    onSelected: (String value) {
                      _userLevelController.text = value;
                    },
                    itemBuilder: (BuildContext context) {
                      return SportLevel()
                          .level
                          .map<PopupMenuItem<String>>((String value) {
                        return new PopupMenuItem(
                            child: new Text(value), value: value);
                      }).toList();
                    },
                  ),
                ),
                Expanded(
                  child: PopupMenuButton<String>(
                    child: TextField(
                      enabled: false,
                      controller: _userMomentController,
                      decoration: InputDecoration(
                        helperText: "Moment",
                      ),
                    ),
                    onSelected: (String value) {
                      _userMomentController.text = value;
                    },
                    itemBuilder: (BuildContext context) {
                      return Moment()
                          .best
                          .map<PopupMenuItem<String>>((String value) {
                        return new PopupMenuItem(
                            child: new Text(value), value: value);
                      }).toList();
                    },
                  ),
                ),
                Expanded(
                  child: PopupMenuButton<String>(
                    child: TextField(
                      enabled: false,
                      controller: _userWeeklyController,
                      decoration: InputDecoration(
                        helperText: "Week or Week end",
                      ),
                    ),
                    onSelected: (String value) {
                      _userWeeklyController.text = value;
                    },
                    itemBuilder: (BuildContext context) {
                      return WeekOrWeekEnd()
                          .best
                          .map<PopupMenuItem<String>>((String value) {
                        return new PopupMenuItem(
                            child: new Text(value), value: value);
                      }).toList();
                    },
                  ),
                ),
                Expanded(
                  child: PopupMenuButton<String>(
                    child: TextField(
                      enabled: false,
                      controller: _userMotivationController,
                      decoration: InputDecoration(
                        helperText: "Week or Week end",
                      ),
                    ),
                    onSelected: (String value) {
                      _userMotivationController.text = value;
                    },
                    itemBuilder: (BuildContext context) {
                      return MyReason()
                          .reason
                          .map<PopupMenuItem<String>>((String value) {
                        return new PopupMenuItem(
                            child: new Text(value), value: value);
                      }).toList();
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Save'),
                      color: Colors.green,
                      textColor: Colors.white,
                      onPressed: () async {
                        user.sport = _userSportController.text;
                        user.level = _userLevelController.text;
                        user.moment = _userMomentController.text;
                        user.weekly = _userWeeklyController.text;
                        user.motivation = _userMotivationController.text;

                        setState(() {
                          _userSportController.text = user.sport;
                          _userLevelController.text = user.level;
                          _userMomentController.text = user.moment;
                          _userWeeklyController.text = user.weekly;
                          _userMotivationController.text = user.motivation;
                        });
                        var firebaseUser = await FirebaseAuth.instance
                            .currentUser(); //very important information here
                        firestoreInstance
                            .collection("users")
                            .document(firebaseUser.uid)
                            .updateData({
                          "sport": _userSportController.text,
                          "level": _userLevelController.text,
                          'moment': _userMomentController.text,
                          'weekly': _userWeeklyController.text,
                          'motivation': _userMotivationController.text,
                        });
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget showSignOut(context) {
    return RaisedButton(
      child: Text("Sign Out"),
      onPressed:  () async {
        await _auth.signOut();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => LoginScreen()));
      },
    );
  }
}
