import 'package:aptus/services/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aptus/services/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aptus/users/users.dart';
import 'package:aptus/screens/home2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, isAppTitle: false, titleText: 'search'),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 250.0),
              child: Text(
                'SPORT',
                style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Colors.black),
              ),
            ),
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DM Sans'),
                hintText: 'Séléctionner un sport',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 3.0,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 3.0,
                  ),
                ),
              ),
            ),
            OurRoundedButtonLarge(
              title: 'Recherche',
              colour: Colors.blueAccent,
              onPressed: createRecord,
            ),
          ],
        ),
      ),
    );
  }
}

final databaseReference = Firestore.instance;

void createRecord() async {
  await databaseReference.collection("user").document("1").setData({
    'title': 'Mastering Flutter',
    'description': 'Programming Guide for Dart'
  });
}
