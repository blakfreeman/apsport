import 'package:aptus/services/components.dart';
import 'package:aptus/services/constants.dart';
import 'package:aptus/services/current_user_auth.dart';
import 'package:aptus/services/helper.dart';
import 'package:aptus/services/list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aptus/screens/player/home.dart';
import 'package:aptus/screens/graphics/apTextFormField.dart';
import 'package:aptus/screens/sign_up/sign_up.i18n.dart';
import 'package:aptus/services/data_base.dart';
import 'package:email_validator/email_validator.dart';
import 'package:aptus/screens/graphics/apRoundedButtonLarge.dart';
import 'package:aptus/screens/graphics/apDropdownButtonFormField.dart';

class OurSignUpForm extends StatefulWidget {
  @override
  _OurSignUpFormState createState() => _OurSignUpFormState();
}

final TextEditingController _usernameController = TextEditingController();
final TextEditingController _agesController = TextEditingController();
final TextEditingController _cityController = TextEditingController();
final TextEditingController _sportController = TextEditingController();
final TextEditingController _sexController = TextEditingController();
final TextEditingController _levelController = TextEditingController();
final TextEditingController _momentController = TextEditingController();
final TextEditingController _weeklyController = TextEditingController();
final TextEditingController _myReasonController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passController = TextEditingController();
final TextEditingController _confirmPassController = TextEditingController();

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

bool _userExist = false;
bool _mailExist = false;
checkUserValue<bool>(String user) {
  OurDatabase.doesNameAlreadyExist(user).then((val) {
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

checkMailValue<bool>(String user) {
  OurDatabase.doesMailAlreadyExist(user).then((val) {
    if (val) {
      print("Email Already Exits");
      _mailExist = val;
    } else {
      print("Email is Available");
      _mailExist = val;
    }
  });
  return _mailExist;
}

void _signUpUser(
    String email,
    String password,
    BuildContext context,
    String username,
    String age,
    String gender,
    String city,
    String sport,
    String level,
    String moment,
    String weekly,
    String motivation) async {
  CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
  final FormState form = _formKey.currentState;
  if (form.validate()) {
    print('Form is valid');
    try {
      String _returnString = await _currentUser.signUpUser(
          username,
          email,
          password,
          age,
          gender,
          city,
          sport,
          level,
          moment,
          weekly,
          motivation);
      if (_returnString == "success") {
        Navigator.pushNamed(context, Home.id);
      } else {
//      Scaffold.of(context).showSnackBar(
//        SnackBar(
//          content: Text(_returnString),
//          duration: Duration(seconds: 2),
//        ),
//      );
      }
    } catch (e) {
      print(e);
    }
  } else {
    print('Form is invalid');
  }
}

class _OurSignUpFormState extends State<OurSignUpForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                ApTextFormField(
                  controller: _usernameController,
                  validator: (val) {
                    if (val.trim().length < 3 || val.isEmpty) {
                      return "Choose a longer name".i18n;
                    } else if (val.trim().length > 12) {
                      return "Choose a shorter name".i18n;
                    } else {
                      if (checkUserValue(val))
                        return "Choose another name, this one is already taken"
                            .i18n;
                      else
                        return null;
                    }
                  },
                  obscureText: false,
                  hintText: 'User name'.i18n,
                ),
                SizedBox(
                  height: 20.0,
                ),
                ApTextFormField(
                  controller: _emailController,
                  validator: (email) => EmailValidator.validate(email)
                      ? checkMailValue(email)
                          ? "This email address is already registered in Aptus"
                              .i18n
                          : null
                      : "Correct the email address format".i18n,
                  obscureText: false,
                  hintText: "Email".i18n,
                ),
                SizedBox(
                  height: 20.0,
                ),
                ApTextFormField(
                  controller: _passController,
                  hintText: "Password".i18n,
                  obscureText: true,
                ),
                SizedBox(
                  height: 20.0,
                ),
                ApTextFormField(
                  controller: _confirmPassController,
                  hintText: "Password confirmation".i18n,
                  obscureText: true,
                  validator: (confirmPassword) {
                    if (_passController.text == confirmPassword)
                      return null;
                    else
                      return "Passwords don't match".i18n;
                  },
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: ApDropdownButtonFormField(
                        onChanged: (String value) {
                          _sexController.text = value;
                        },
                        value: _sexController.text,
                        validator: (value) =>
                            value.isEmpty ? "Select a gender".i18n : null,
                        items: Gender().sex.map((String gender) {
                          return DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          );
                        }).toList(),
                        hintText: "Gender".i18n,
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                        child: ApDropdownButtonFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Select your age category'.i18n;
                        } else {
                          return null;
                        }
                      },
                      hintText: 'Age'.i18n,
                      onChanged: (String value) {
                        _agesController.text = value;
                      },
                      value: _agesController.text,
                      items: Ages().numbers.map((String gender) {
                        return DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                    )),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: ApDropdownButtonFormField(
                          hintText: 'Sport'.i18n,
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Select your main sport'.i18n;
                            } else {
                              return null;
                            }
                          },
                          onChanged: (String value) {
                            _sportController.text = value;
                          },
                          value: _sportController.text,
                          items: Sport().sport.map((String sportname) {
                            return DropdownMenuItem(
                              value: sportname,
                              child: Text(sportname),
                            );
                          }).toList()),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: ApDropdownButtonFormField(
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Share your level for your main sport'.i18n;
                          } else {
                            return null;
                          }
                        },
                        hintText: 'Sport level'.i18n,
                        onChanged: (String value) {
                          _levelController.text = value;
                        },
                        items: SportLevel().level.map((String levelname) {
                          return DropdownMenuItem(
                            value: levelname,
                            child: Text(levelname),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ApDropdownButtonFormField(
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Tell us about the day(s) you want to practice'
                                .i18n;
                          } else {
                            return null;
                          }
                        },
                        hintText: 'Best days for sport'.i18n,
                        onChanged: (String value) {
                          _weeklyController.text = value;
                        },
                        items: WeekOrWeekEnd().best.map((String day) {
                          return DropdownMenuItem(
                            value: day,
                            child: Text(day),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: ApDropdownButtonFormField(
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Tell us at what time you are available for sport'
                                .i18n;
                          } else {
                            return null;
                          }
                        },
                        hintText: 'Best time to play'.i18n,
                        onChanged: (String value) {
                          _momentController.text = value;
                        },
                        items: Moment().best.map((String daytime) {
                          return DropdownMenuItem(
                            value: daytime,
                            child: Text(daytime),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ApDropdownButtonFormField(
                        validator: (val) {
                          if (val.isEmpty) {
                            return "What's your Motivation?".i18n;
                          } else {
                            return null;
                          }
                        },
                        hintText: 'Goal'.i18n,
                        onChanged: (String value) {
                          _myReasonController.text = value;
                        },
                        items: MyReason().reason.map((String quote) {
                          return DropdownMenuItem(
                            value: quote,
                            child: Text(quote),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: ApDropdownButtonFormField(
                        hintText: 'City'.i18n,
                        value: _cityController.text,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Select the closest city'.i18n;
                          } else {
                            return null;
                          }
                        },
                        onChanged: (String value) {
                          _cityController.text = value;
                        },
                        items: City().city.map((String cityname) {
                          return DropdownMenuItem(
                            value: cityname,
                            child: Text(cityname),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ApRoundedButtonLarge(
                  title: 'Save'.i18n.toUpperCase(),
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
//                      Scaffold.of(context).showSnackBar(
//                        SnackBar(
//                          content: Text("Passwords do not match"),
//                          duration: Duration(seconds: 4),
//                        ),
//                      );
                      //}
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
