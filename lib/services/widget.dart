import 'package:aptus/model/users.dart';
import 'package:aptus/screens/graphics/apUserCard.dart';
import 'package:aptus/screens/player/chat/chat_screen.dart';
import 'package:aptus/screens/player/user_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

AppBar header(context, {bool isAppTitle = false, String titleText}) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Text(
      isAppTitle ? 'APTUS' : titleText,
      style: TextStyle(
        fontFamily: 'DM Sans',
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: isAppTitle ? 40.0 : 22.0,
      ),
    ),
    centerTitle: true,
    backgroundColor: Colors.blueAccent,
  );
}


