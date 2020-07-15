import 'package:aptus/model/users.dart';
import'package:flutter/material.dart';

class OurPlayerInfo extends StatelessWidget {

  final OurPlayer eachUser;
  OurPlayerInfo({ this.eachUser });

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => print('tapped'),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey,
              ),
              title: Text(
                eachUser.username,
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                eachUser.sport,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              thickness: 1.0
              ,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}