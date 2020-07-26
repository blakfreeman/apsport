import 'package:aptus/screens/login/login.dart';
import 'package:aptus/screens/player/home.dart';
import 'package:aptus/services/helper.dart';
import 'package:flutter/material.dart';

class OurRoot extends StatefulWidget {
  static const String id = 'ourRoot';

  @override
  _OurRootState createState() => _OurRootState();
}

//
class _OurRootState extends State<OurRoot> {

  bool userIsLoggedIn;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }
//chech doc helper function
  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn  = true;//this must be wrong
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return userIsLoggedIn != null ?  userIsLoggedIn ? Home() : LoginScreen()
        : Container(
        child: Center(
        child: LoginScreen(),
    ),
    );
  }
}
