import 'package:aptus/model/users.dart';
import 'package:aptus/screens/player/user_details.dart';
import 'package:aptus/services/constants.dart';
import 'package:aptus/services/current_user_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aptus/services/header.dart';
import 'package:aptus/services/location.dart';
import 'package:provider/provider.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:aptus/screens/graphics/apRoundFilterButton.dart';
import 'package:aptus/screens/graphics/apUserCard.dart';
import 'package:aptus/screens/player/maine_page.i18n.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/background_3.jpg'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                    ),
                    CircleAvatar(
                      backgroundImage: ExactAssetImage(
                          'assets/images/anthony.jpg'), //TODO get picture from database
                      minRadius: 35,
                      maxRadius: 40,
                    ),
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          'assets/images/icon_new.png',
                          height: 70.0,
                        ),
                      ),
                    ),
                    Container(
                      width: 70,
                      height: 70,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 20,
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ApRoundFilterButton(
                        title: 'Near me'.i18n,
                        onPressed: () {
                          print("filter near me"); //TODO implement filter
                        },
                        icon: Icons.near_me,
                      ),
                      ApRoundFilterButton(
                        title: 'My sport'.i18n,
                        onPressed: () {
                          print("filter sport"); //TODO implement filter
                        },
                        icon: Icons.fitness_center,
                      ),
                      ApRoundFilterButton(
                        title: 'My likes'.i18n,
                        onPressed: () {
                          print("filter like"); //TODO implement filter
                        },
                        icon: Icons.thumb_up,
                      ),
                      ApRoundFilterButton(
                        title: 'My coaches'.i18n,
                        onPressed: () {
                          print("filter coach"); //TODO implement filter
                        },
                        icon: MdiIcons.whistle,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder(
                            stream: getUsersStreamSnapshots(context),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData)
                                return CircularProgressIndicator();
                              return new ListView.builder(
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (BuildContext context,
                                          int
                                              index) => //to return the users matching current user sport
                                      buildUserCard(context,
                                          snapshot.data.documents[index]));
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUserCard(BuildContext context, DocumentSnapshot document) {
    final ourPlayer = OurPlayer.fromSnapshot(document);

    return new ApUserCard(
      name: ourPlayer.username,
      sport: ourPlayer.sport,
      level: ourPlayer.level,
      goal: ourPlayer.motivation,
      pic: 'assets/images/anthony.jpg', // TODO get pic from database
      role: 'Player', //TODO get the role from database
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserDetails(ourPlayer: ourPlayer)),
        );
      },
    );
  }
}
