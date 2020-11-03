import 'package:aptus/model/users.dart';
import 'package:aptus/services/utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'enum.dart';

class AuthMethods {
  static final Firestore _firestore = Firestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  static final Firestore firestore = Firestore.instance;

  static final CollectionReference _userCollection =
  _firestore.collection('users');

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser;
    currentUser = await _auth.currentUser();
    return currentUser;
  }

  Future<OurPlayer> getUserDetails() async {
    FirebaseUser currentUser = await getCurrentUser();

    DocumentSnapshot documentSnapshot =
    await _userCollection.document(currentUser.uid).get();
    return OurPlayer.fromMap(documentSnapshot.data);
  }

  Future<OurPlayer> getUserDetailsById(id) async {
    try {
      DocumentSnapshot documentSnapshot =
      await _userCollection.document(id).get();
      return OurPlayer.fromMap(documentSnapshot.data);
    } catch (e) {
      print(e);
      return null;
    }
  }


  Future<bool> authenticateUser(FirebaseUser user) async {
    QuerySnapshot result = await firestore
        .collection('users')
        .where('email', isEqualTo: user.email)
        .getDocuments();

    final List<DocumentSnapshot> docs = result.documents;

    //if user is registered then length of list > 0 or else less than 0
    return docs.length == 0 ? true : false;
  }

  Future<void> addDataToDb(FirebaseUser currentUser) async {
    String username = Utils.getUsername(currentUser.email);

    OurPlayer user = OurPlayer(
        uid: currentUser.uid,
        email: currentUser.email,
        photoUrl: currentUser.photoUrl,
        username: username);

    firestore
        .collection('users')
        .document(currentUser.uid)
        .setData(user.toMap(user));
  }

  Future<List<OurPlayer>> fetchAllUsers(FirebaseUser currentUser) async {
    List<OurPlayer> userList = List<OurPlayer>();

    QuerySnapshot querySnapshot =
    await firestore.collection('users').getDocuments();
    for (var i = 0; i < querySnapshot.documents.length; i++) {
      if (querySnapshot.documents[i].documentID != currentUser.uid) {
        userList.add(OurPlayer.fromMap(querySnapshot.documents[i].data));
      }
    }
    return userList;
  }



  void setUserState({@required String userId, @required UserState userState}) {
    int stateNum = Utils.stateToNum(userState);

    _userCollection.document(userId).updateData({
      "state": stateNum,
    });
  }

  Stream<DocumentSnapshot> getUserStream({@required String uid}) =>
      _userCollection.document(uid).snapshots();
}