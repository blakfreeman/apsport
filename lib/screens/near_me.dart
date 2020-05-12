import 'package:aptus/services/current_user_auth.dart';
import 'package:flutter/material.dart';
import 'package:aptus/services/header.dart';
import 'package:provider/provider.dart';

import 'package:aptus/screens/root.dart';

class NearMe extends StatefulWidget {
  static const String id = 'near_me';

  @override
  _NearMeState createState() => _NearMeState();
}

class _NearMeState extends State<NearMe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: Center(
        child: RaisedButton(
          child: Text('Check angela vidoe about the meteo app'),
          onPressed: () async {
            CurrentUser _currentUser =
                Provider.of<CurrentUser>(context, listen: false);
            String _returnString = await _currentUser.signOut();
            if (_returnString == 'succes') {
              Navigator.pushNamed(context, OurRoot.id);
            }
          },
        ),
      ),
    );
  }
}
