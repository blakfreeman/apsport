import 'package:aptus/model/users.dart';
import 'package:aptus/screens/sign_up/Sign_up.dart';
import 'package:aptus/services/current_user_auth.dart';
import 'package:aptus/screens/player/maine_page/our_player_card.dart';
import 'package:aptus/services/data_base.dart';
import 'package:aptus/services/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:aptus/services/header.dart';
import 'package:aptus/services/location.dart';
import 'package:provider/provider.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:aptus/screens/root.dart';

// normally I 'm supposed to add the goe localisation to our app but it's taking me to much time of research, so I ll add it later on, we don't have enough user to need it soon
class MainePage extends StatefulWidget {
  static const String id = 'maine_page';

  @override
  _MainePageState createState() => _MainePageState();
}


class _MainePageState extends State<MainePage> {
  Firestore _positionInFireStore = Firestore.instance;
  Geoflutterfire geo = Geoflutterfire();
  Location location =  Location();

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
    final uid = await Provider.of<CurrentUser>(context,listen: false).getCurrentUID();
     await location.getCurrentLocation();
    GeoFirePoint point = geo.point(latitude: location.latitude, longitude: location.longitude);
    return _positionInFireStore.collection('users').document(uid).collection(
        'UserPosition').document().setData({
      'position': point.data,
      'Position Created': Timestamp.now(),
    });
  }

// get users the collection location reference or query
  Stream<QuerySnapshot> getUsersStreamSnapshots(
      BuildContext context) async* {
    yield* Firestore.instance
        .collection('users'
    ).snapshots();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: Container(
      child:   FutureBuilder(
        future: Provider.of<CurrentUser>(context).getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return showHomePageWithUsers(snapshot.data);
          } else {
            return circularProgress();
          }
        },
      )
      ),
    );

  }
  Widget displayUserSugestion(BuildContext context, DocumentSnapshot document) {
    OurPlayer eachUsers = OurPlayer.fromDocument(document);

    return new Container(
      child: Card(
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Row(children: <Widget>[
                    Text(
                      eachUsers.username,
                    style:
                    TextStyle(fontFamily: 'DM Sans',
                        fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                  ]),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, SignUpScreen.id);
          },
        ),
      ),
    );
  }
  Widget showHomePageWithUsers(OurPlayer eachUsers) {
    return Column(
      children: <Widget>[
        Expanded(
          child: StreamBuilder(
              stream: getUsersStreamSnapshots(context),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text("Loading...");
                return new ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) =>
                        displayUserSugestion(context, snapshot.data.documents[index]));
              }),
        ),
      ],
    );
  }
}



