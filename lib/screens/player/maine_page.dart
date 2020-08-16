import 'package:aptus/model/users.dart';
import 'package:aptus/screens/player/user_details.dart';
import 'package:aptus/services/current_user_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aptus/services/header.dart';
import 'package:aptus/services/location.dart';
import 'package:provider/provider.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

// normally I 'm supposed to add the goe localisation to our app but it's taking me to much time of research, so I ll add it later on, we don't have enough user to need it soon
class MainePage extends StatefulWidget {
  static const String id = 'maine_page';

  @override
  _MainePageState createState() => _MainePageState();
}

class _MainePageState extends State<MainePage> {
  Firestore _positionInFireStore = Firestore.instance;
  Geoflutterfire geo = Geoflutterfire();
  Location location = Location();
  final usersRef = Firestore.instance.collection('users');

  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    //function to delete old pos
    _addCurrentUserPosition();
  }

  // Set GeoLocation Data for the current user
  _addCurrentUserPosition() async {
    Location location = Location();
    final uid =
        await Provider.of<CurrentUser>(context, listen: false).getCurrentUID();
    await location.getCurrentLocation();
    GeoFirePoint point =
        geo.point(latitude: location.latitude, longitude: location.longitude);
    return _positionInFireStore
        .collection('users')
        .document(uid)
        .collection('UserPosition')
        .document()
        .setData({
      'position': point.data,
      'Position Created': Timestamp.now(),
    });
  }

// get users the collection location reference or query
  Stream<QuerySnapshot> getUsersStreamSnapshots(BuildContext context) async* {
    yield* Firestore.instance.collection('users').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: StreamBuilder(
          stream: getUsersStreamSnapshots(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return new ListView.builder(
                // I ll you use a GridView  later
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context,
                        int index) => //to return the users matching current user sport
                    buildUserCard(context, snapshot.data.documents[index]));
          }),
    );
  }

  Widget buildUserCard(BuildContext context, DocumentSnapshot document) {
    final ourPlayer = OurPlayer.fromSnapshot(document);

    return new Container(
      width: 200,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        color: Colors.white,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UserDetails(ourPlayer: ourPlayer)),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            ourPlayer.username,
                            style: new TextStyle(fontSize: 20.0),
                          ),
                        )),
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              AssetImage('assets/images/anthony.jpg'),
                        ),
                        Container(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                ourPlayer.sport,
                                style: new TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                ourPlayer.level,
                                style: new TextStyle(fontSize: 15.0),
                              ),
                            )),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          ourPlayer.motivation,
                          style: new TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
