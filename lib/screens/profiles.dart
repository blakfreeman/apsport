import 'dart:developer';

import 'package:aptus/services/header.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:aptus/services/data_base.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  static const String id = 'profiles';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, isAppTitle: false, titleText: 'PROFIL'),
      body:  SingleChildScrollView(
        child:
        Column(
          children: <Widget>[

          ],
        ),
      ),


    );


  }
}
