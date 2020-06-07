import 'package:aptus/model/users.dart';
import 'package:aptus/services/current_user_auth.dart';
import 'package:aptus/services/components.dart';
import 'package:aptus/services/data_base.dart';
import 'package:aptus/services/header.dart';
import 'package:aptus/services/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//add everyStep of the 1 man startup ep 47
class Profile extends StatefulWidget {


  @override
  _ProfileState createState() => _ProfileState();
}



Stream<QuerySnapshot> getUserInfo(BuildContext context) async* {
  final uid = await Provider.of<CurrentUser>(context).getUser();
  yield* Firestore.instance
      .collection('users')
      .document(uid)
      .collection('user info')
      .snapshots();
}

class _ProfileState extends State<Profile> {
  TextEditingController _userUsernameController = TextEditingController();
  OurPlayer user = OurPlayer();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: "Profile"),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: Provider.of<CurrentUser>(context).getUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return displayUserInformation(context, snapshot);
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget displayUserInformation(context, snapshot) {
    final authData = snapshot.data;
    return Column(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[

              FutureBuilder(
                future: _getProfileData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    _userUsernameController.text = user.username;
                  }
                  return OurContainer(
                    child: Column(
                      children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Email: ${authData.email}",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Text('Username: ${_userUsernameController.text}'),

                        Text('Username: ${user.username}'),],


                    ),

                  );
                },
              ),
              showSignOut(context),
              RaisedButton(
                child: Text("Edit User"),
                onPressed: () {
                  _userEditBottomSheet(context);
                },
              )
            ],
          ),
        ),
      ],
    );
  }


  Future <QuerySnapshot> _getUserCollection () async {
    final uid = await Provider.of<CurrentUser>(context).getCurrentUID();
    await Firestore.instance
        .collection('users')
        .document(uid)
        .collection('user info')
        .document()
        .get();

  }
  _getProfileData() async {
    final uid = await Provider.of<CurrentUser>(context).getCurrentUID();
    await Firestore.instance
        .collection('users')
        .document(uid)
        .get()

    ;
  }

  void _userEditBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * .60,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 15.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Update Profile"),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.cancel),
                      color: Colors.blueAccent,
                      iconSize: 25,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: TextField(
                          controller: _userUsernameController,
                          decoration: InputDecoration(
                            helperText: "username",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Save'),
                      color: Colors.green,
                      textColor: Colors.white,
                      onPressed: () async {
                        user.username = _userUsernameController.text;
                        setState(() {
                          _userUsernameController.text = user.username;
                        });
                        final uid = await Provider.of<CurrentUser>(context)
                            .getCurrentUID();
                        await Firestore.instance
                            .collection('users')
                            .document(uid)
                            .setData
                        (user.toJson());
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget showSignOut(context) {
    return RaisedButton(
      child: Text("Sign Out"),
      onPressed: () async {
        try {
          await Provider.of<CurrentUser>(context).signOut();
        } catch (e) {
          print(e);
        }
      },
    );
  }
}
