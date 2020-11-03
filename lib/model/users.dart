import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel {
  final List<OurPlayer> users;

  UsersModel({this.users});

  factory UsersModel.fromJson(List<dynamic> json) {
    var users = json.map((userItem) => OurPlayer.fromJson(userItem)).toList();
    return UsersModel(users: users);
  }
}


class OurPlayer {
   String uid;
   String photoUrl;
   String username;
   String email;
   String gender;
   String age;
   String city;
   String sport;
   String level;
   String moment;
   String weekly;
   String motivation;
   int state;
   Timestamp accountCreated;

//take care of the carlibraces
  OurPlayer({
    this.uid,
    this.photoUrl,
    this.username,
    this.email,
    this.gender,
    this.age,
    this.city,
    this.sport,
    this.level,
    this.moment,
    this.weekly,
    this.motivation,
    this.state,
    this.accountCreated,
  });



  Map toMap(OurPlayer user) {
    var data = Map<String, dynamic>();
    data['uid'] = user.uid;
    data['username'] = user.username;
    data['email'] = user.email;
    data['gender'] = user.gender;
    data["age"] = user.age;
    data["city"] = user.city;
    data["sport"] = user.sport;
    data["level"] = user.level;
    data["moment"] = user.moment;
    data["weekly"] = user.weekly;
    data["motivation"] = user.motivation;
    data["photoUrl"] = user.photoUrl;
    data["state"] = user.state;
    data["accountCreated"] = user.accountCreated;
    return data;
  }

  OurPlayer.fromMap( Map<String,dynamic> mapData){
    this.uid = mapData['uid'];
    this.photoUrl= mapData['photoUrl'];
    this.username= mapData['username'];
    this.email= mapData['email'];
    this.gender= mapData['gender'];
    this.age= mapData['age'];
    this.city= mapData['city'];
    this.sport= mapData['sport'];
    this.level= mapData['level'];
    this.moment= mapData['moment'];
    this.weekly= mapData['weekly'];
    this.motivation= mapData['motivation'];
    this.state = mapData['state'];
    this.accountCreated = mapData['accountCreated'];
  }


  factory OurPlayer.fromJson(dynamic json) {
    return OurPlayer(
      uid: json['uid'].toString(),
      photoUrl : json['photoUrl'].toString(),
      username: json['username'],
      email: json['email'].toString(),
      gender: json['gender'],
      age: json['age'].toString(),
      city: json['city'],
      sport: json['sport'],
      level: json['level'],
      moment: json['moment'],
      motivation: json['motivation'],
      state: json['state'],
      accountCreated: json['accountCreated'],

    );
  }

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'photoUrl': photoUrl,
    'username': username,
    'email': email,
    'gender': gender,
    'age': age,
    'city': city,
    'sport': sport,
    'level': level,
    'moment': moment,
    'weekly': weekly,
    'motivation': motivation,
    'state': state,
    'accountCreated': accountCreated,


  };



  //creating a Player object from a firebase snapshot
  OurPlayer.fromSnapshot(DocumentSnapshot snapshot) :
        uid = snapshot['uid'],
        photoUrl =snapshot['photoUrl'],
        username= snapshot['username'],
        email= snapshot['email'],
        age= snapshot['age'],
        gender= snapshot['gender'],
        city= snapshot['city'],
        sport= snapshot['sport'],
        level= snapshot['level'],
        moment= snapshot['moment'],
        weekly= snapshot['weekly'],
        motivation= snapshot['motivation'],
        state= snapshot['state'],
  accountCreated = snapshot['accountCreated'];

  factory OurPlayer.fromDocument(DocumentSnapshot doc) {
    return OurPlayer(
      uid: doc['uid'],
      photoUrl:doc['photoUrl'],
      username: doc['username'],
      email: doc['email'],
      age: doc['age'],
      gender: doc['gender'],
      city:doc['city'],
      sport: doc['sport'],
      level: doc['level'],
      moment: doc['moment'],
      weekly: doc['weekly'],
      motivation: doc['motivation'],
      state: doc['state'],
      accountCreated: doc['accountCreated'],
    );
  }
}
