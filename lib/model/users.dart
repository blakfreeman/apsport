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
  Timestamp accountCreated;

//take care of the carlibraces
  OurPlayer({
    this.uid,
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
    this.accountCreated,
  });


  factory OurPlayer.fromJson(dynamic json) {
    return OurPlayer(
      uid: json['uid'].toString(),
      username: json['username'],
      email: json['email'].toString(),
      gender: json['gender'],
      age: json['age'].toString(),
      city: json['city'],
      sport: json['sport'],
      level: json['level'],
      moment: json['moment'],
      motivation: json['motivation'],
      accountCreated: json['accountCreated'],









    );
  }

  Map<String, dynamic> toJson() => {
    'uid': uid,
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

  };



  //creating a Player object from a firebase snapshot
  OurPlayer.fromSnapshot(DocumentSnapshot snapshot) :
        uid = snapshot['uid'],
        username= snapshot['username'],
        email= snapshot['email'],
        age= snapshot['age'],
        gender= snapshot['gender'],
        city= snapshot['city'],
        sport= snapshot['sport'],
        level= snapshot['level'],
        moment= snapshot['moment'],
        weekly= snapshot['weekly'],
        motivation= snapshot['motivation'];

  factory OurPlayer.fromDocument(DocumentSnapshot doc) {
    return OurPlayer(
      uid: doc['uid'],
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
    );
  }


}
