import 'package:aptus/model/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class OurDatabase {
  final usersRef = Firestore.instance.collection;

//Todo create the same for the coaches
  Future<String> createPlayer(OurPlayer user) async {
    String retVal = "error";

    try {
      await usersRef('users')
          .document(user.uid)
          .setData({
        'uid': user.uid,
        'username': user.username,
        'email': user.email,
        'sport': user.sport,
        'level': user.level,
        'motivation': user.motivation,
        'accountCreated': Timestamp.now(),
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<OurPlayer> getUserInfo(String uid) async {
    OurPlayer retVal = OurPlayer();

    try {
      DocumentSnapshot _docSnapshot =
          await usersRef("users").document(uid).get();
      retVal.uid = uid;
      retVal.username = _docSnapshot.data["username"];
      retVal.email = _docSnapshot.data["email"];
      retVal.sport = _docSnapshot.data["sport"];
      retVal.level = _docSnapshot.data["level"];
      retVal.motivation = _docSnapshot.data["motivation"];
      retVal.accountCreated = _docSnapshot.data["accountCreated"];
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}
