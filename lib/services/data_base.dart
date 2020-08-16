import 'package:aptus/model/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class OurDatabase extends ChangeNotifier {
  final String uid;
  OurDatabase({this.uid});

  final usersRef = Firestore.instance.collection('users');

//Todo create the same for the coaches
  Future<String> createPlayer(OurPlayer user) async {
    String retVal = "error";

    try {
      await usersRef.document(user.uid).setData({
        'uid': user.uid,
        'username': user.username,
        'email': user.email,
        'age': user.age,
        'gender': user.gender,
        'city': user.city,
        'sport': user.sport,
        'level': user.level,
        'moment': user.moment,
        'weekly': user.weekly,
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
      DocumentSnapshot _docSnapshot = await usersRef.document(uid).get();
      retVal.uid = uid;
      retVal.username = _docSnapshot.data["username"];
      retVal.email = _docSnapshot.data["email"];
      retVal.age = _docSnapshot.data["age"];
      retVal.gender = _docSnapshot.data["gender"];
      retVal.city = _docSnapshot.data["city"];
      retVal.sport = _docSnapshot.data["sport"];
      retVal.level = _docSnapshot.data["level"];
      retVal.moment = _docSnapshot.data["moment"];
      retVal.weekly = _docSnapshot.data["weekly"];
      retVal.motivation = _docSnapshot.data["motivation"];
      retVal.accountCreated = _docSnapshot.data["accountCreated"];
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  // users list from snapshot
  List<OurPlayer> _ourPlayerListFormSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return OurPlayer(
        username: doc.data['username'],
        email: doc.data['email'],
        age: doc.data['age'],
        gender: doc.data['gender'],
        city: doc.data['city'],
        sport: doc.data['sport'],
        level: doc.data['level'],
        moment: doc.data['moment'],
        weekly: doc.data['weekly'],
        motivation: doc.data['motivation'],
      );
    }).toList();
  }

  // get Our player stream
  Stream<List<OurPlayer>> get player {
    return usersRef.snapshots().map(_ourPlayerListFormSnapshot);
  }
}

Future<bool> doesNameAlreadyExist(String name) async {
  final QuerySnapshot result = await Firestore.instance
      .collection('users')
      .where('username', isEqualTo: name)
      .limit(1)
      .getDocuments();
  final List<DocumentSnapshot> documents = result.documents;
  return documents.length == 1;

  Future<void> addUserInfo(userData) async {
    Firestore.instance.collection("users").add(userData).catchError((e) {
      print(e.toString());
    });
  }

  searchByName(String searchField) {
    return Firestore.instance
        .collection("users")
        .where('userName', isEqualTo: searchField)
        .getDocuments();
  }

  Future<bool> addChatRoom(chatRoom, chatRoomId) {
    return Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .setData(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  getChats(String chatRoomId) async {
    return Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  Future<void> addMessage(String chatRoomId, chatMessageData) {
    return Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserChats(String itIsMyName) async {
    return Firestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }
}

Future<bool> doesMailAlreadyExist(String name) async {
  final QuerySnapshot result = await Firestore.instance
      .collection('users')
      .where('email', isEqualTo: name)
      .limit(1)
      .getDocuments();
  final List<DocumentSnapshot> documents = result.documents;
  return documents.length == 1;
}
