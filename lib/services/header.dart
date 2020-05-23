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
    backgroundColor: Theme.of(context).primaryColor,
  );
}
