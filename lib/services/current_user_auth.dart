import 'package:aptus/model/users.dart';
import 'package:aptus/screens/sign_up/sign_up_form.dart';
import 'package:aptus/services/data_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:aptus/services/helper.dart';



class CurrentUser extends ChangeNotifier {
  OurPlayer _currentUser = OurPlayer();

  OurPlayer get getCurrentUser => _currentUser;
  FirebaseAuth _auth = FirebaseAuth.instance;

final usersRef = Firestore.instance.collection('users');

  Future<String> onStartUp() async {
    String retVal = "error";

    try {
      FirebaseUser _firebaseUser = await _auth.currentUser();
      if (_firebaseUser != null) {
        _currentUser = await OurDatabase().getUserInfo(_firebaseUser.uid);
        if (_currentUser != null) {
          retVal = "success";
        }
      }
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> getCurrentUID() async {
    return (await _auth.currentUser()).uid;
  }

  Future getUser() async {
    return await _auth.currentUser();
  }

  Future bye() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  Future<String> signOut() async {
    String retVal = "error";

    try {
      await _auth.signOut();
      _currentUser = OurPlayer();
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> signUpUser(String username,
      String email, String password,String age, String gender,String city, String sport, String level,String moment,String weekly, String motivation) async {
    String retVal = "error";
    OurPlayer _user = OurPlayer();
    try {
      AuthResult _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _user.uid = _authResult.user.uid;
      _user.email = _authResult.user.email;
      _user.username = username;
      _user.gender = gender;
      _user.age = age;
      _user.city = city;
      _user.sport = sport;
      _user.level = level;
      _user.moment = moment;
      _user.weekly = weekly;
      _user.motivation = motivation;
      HelperFunctions.saveUserLoggedInSharedPreference(true);

      String _returnString = await OurDatabase().createPlayer(_user);
      if (_returnString == "success") {
        retVal = "success";
      }
    } on PlatformException catch (e) {
      retVal = e.message;
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> loginUserWithEmail(String email, String password) async {
    String retVal = "error";

    try {
      AuthResult _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      _currentUser = await OurDatabase().getUserInfo(_authResult.user.uid);
      if (_currentUser != null) {
        retVal = "success";
      }
    } on PlatformException catch (e) {
      retVal = e.message;
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}
