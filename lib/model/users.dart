import 'package:cloud_firestore/cloud_firestore.dart';

class OurPlayer {
  String uid;
  String email;
  String username;
  String sport;
  String level;
  String motivation;
  Timestamp accountCreated;


  OurPlayer({
    this.uid,
    this.email,
    this.username,
    this.sport,
    this.level,
    this.motivation,
    this.accountCreated,

  });
}
