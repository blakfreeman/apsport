import 'package:aptus/model/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class OurDatabase {
  final Firestore _fireStore = Firestore.instance;

  Future<String> createUser(OurUser user) async {
    String retVal = "error";

    try {
      await _fireStore.collection("users").document(user.uid).setData({
        'fullName': user.fullName,
        'email': user.email,
        'accountCreated': Timestamp.now(),
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<OurUser> getUserInfo(String uid) async {
    OurUser retVal = OurUser();

    try {
      DocumentSnapshot _docSnapshot =
          await _fireStore.collection("users").document(uid).get();
      retVal.uid = uid;
      retVal.fullName = _docSnapshot.data["fullName"];
      retVal.email = _docSnapshot.data["email"];
      retVal.accountCreated = _docSnapshot.data["accountCreated"];
      retVal.groupId = _docSnapshot.data['groupId'];
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}
