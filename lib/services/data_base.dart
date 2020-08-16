import 'package:aptus/model/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
class OurDatabase extends ChangeNotifier {

  final String uid;
  OurDatabase({ this.uid });

  final  usersRef = Firestore.instance.collection('users');
  final CollectionReference groupCollection = Firestore.instance.collection('groups');

//Todo create the same for the coaches
  Future<String> createPlayer(OurPlayer user) async {
    String retVal = "error";

    try {
      await usersRef
          .document(user.uid)
          .setData({
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
      DocumentSnapshot _docSnapshot =
          await usersRef.document(uid).get();
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
    return snapshot.documents.map((doc){
      //print(doc.data);
      return OurPlayer(
          username: doc.data['username'],
          email: doc.data['email'],
          age: doc.data['age'],
          gender: doc.data['gender'],
          city: doc.data['city'],
          sport: doc.data['sport'],
          level: doc.data['level'] ,
          moment: doc.data['moment'],
          weekly: doc.data['weekly'] ,
          motivation: doc.data['motivation'],
      );
    }).toList();
  }

  // get Our player stream
  Stream <List<OurPlayer>> get player {
    return usersRef.snapshots()
        .map(_ourPlayerListFormSnapshot);
  }


  Future<void> addUserInfo(userData) async {
    Firestore.instance.collection("users").add(userData).catchError((e) {
      print(e.toString());
    });
  }


  // create group
  Future createGroup(String username, String teamName) async {
    DocumentReference groupDocRef = await groupCollection.add({
      'teamName': teamName,
      'groupIcon': '',
      'admin': username,
      'members': [],
      //'messages': ,
      'groupId': '',
      'recentMessage': '',
      'recentMessageSender': ''
    });

    await groupDocRef.updateData({
      'members': FieldValue.arrayUnion([uid + '_' + username]),
      'groupId': groupDocRef.documentID
    });
    DocumentReference userDocRef = usersRef.document(uid);
    return await userDocRef.updateData({
      'groups': FieldValue.arrayUnion([groupDocRef.documentID + '_' + teamName])
    });
  }

  // toggling the user group join
  Future togglingGroupJoin(String groupId, String teamName, String username) async {

    DocumentReference userDocRef = usersRef.document(uid);
    DocumentSnapshot userDocSnapshot = await userDocRef.get();

    DocumentReference groupDocRef = groupCollection.document(groupId);

    List<dynamic> groups = await userDocSnapshot.data['groups'];

    if(groups.contains(groupId + '_' + teamName)) {
      //print('hey');
      await userDocRef.updateData({
        'groups': FieldValue.arrayRemove([groupId + '_' + teamName])
      });

      await groupDocRef.updateData({
        'members': FieldValue.arrayRemove([uid + '_' + username])
      });
    }
    else {
      //print('nay');
      await userDocRef.updateData({
        'groups': FieldValue.arrayUnion([groupId + '_' + teamName])
      });

      await groupDocRef.updateData({
        'members': FieldValue.arrayUnion([uid + '_' + username])
      });
    }
  }

  // has user joined the group
  Future<bool> isUserJoined(String groupId, String teamName, String username) async {

    DocumentReference userDocRef = usersRef.document(uid);
    DocumentSnapshot userDocSnapshot = await userDocRef.get();

    List<dynamic> groups = await userDocSnapshot.data['groups'];


    if(groups.contains(groupId + '_' + teamName)) {
      //print('he');
      return true;
    }
    else {
      //print('ne');
      return false;
    }
  }
  searchBySport(String searchField) {
    return Firestore.instance
        .collection("users")
        .where('sport', isEqualTo: searchField)
        .getDocuments();
  }


  searchByName(String searchField) {
    return Firestore.instance
        .collection("users")
        .where('username', isEqualTo: searchField)
        .getDocuments();
  }

  getUserInfoForChat(String email) async {
    return Firestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments()
        .catchError((e) {
      print(e.toString());
    });
  }


  // get user data
  Future getUserData(String email) async {
    QuerySnapshot snapshot = await usersRef.where('email', isEqualTo: email).getDocuments();
    print(snapshot.documents[0].data);
    return snapshot;
  }


  // get user groups
  getUserGroups() async {
    // return await Firestore.instance.collection("users").where('email', isEqualTo: email).snapshots();
    return Firestore.instance.collection("users").document(uid).snapshots();
  }



  // send message
  sendMessage(String groupId, chatMessageData) {
    Firestore.instance.collection('groups').document(groupId).collection('messages').add(chatMessageData);
    Firestore.instance.collection('groups').document(groupId).updateData({
      'recentMessage': chatMessageData['message'],
      'recentMessageSender': chatMessageData['sender'],
      'recentMessageTime': chatMessageData['time'].toString(),
    });
  }




  // get chats of a particular group
  getTeamChats(String groupId) async {
    return Firestore.instance.collection('groups').document(groupId).collection('messages').orderBy('time').snapshots();
  }


  // search groups
  searchByTeamName(String teamName) {
    return Firestore.instance.collection("groups").where('groupName', isEqualTo: teamName).getDocuments();
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

  getChats(String chatRoomId) async{
    return Firestore.instance
        .collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }


  Future<void> addMessage(String chatRoomId, chatMessageData){

    return Firestore.instance.collection("chatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(chatMessageData).catchError((e){
      print(e.toString());
    });
  }

  getUserChats(String itIsMyName) async {
    return  Firestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }



}

