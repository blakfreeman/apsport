import 'package:aptus/model/users.dart';
import 'package:aptus/screens/player/user_details.dart';
import 'package:aptus/screens/player/search.dart';
import 'package:aptus/screens/player/user_details.dart';
import 'package:aptus/screens/player/user_details.dart';
import 'package:aptus/screens/player/user_details.dart';
import 'package:aptus/services/current_user_auth.dart';
import 'package:aptus/services/progress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aptus/services/location.dart';
import 'package:provider/provider.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:aptus/screens/graphics/apRoundFilterButton.dart';
import 'package:aptus/screens/graphics/apUserCard.dart';
import 'package:aptus/screens/player/maine_page.i18n.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// normally I 'm supposed to add the goe localisation to our app but it's taking me to much time of research, so I ll add it later on, we don't have enough user to need it soon
FirebaseUser loggedInUser;

enum Filter {
  sameSport,
  myCoach,
  nearMe,
  following,
}


class MainePage extends StatefulWidget {
  static const String id = 'maine_page';
  final OurPlayer currentUser;

  const MainePage({Key key, this.currentUser}) : super(key: key);
  @override
  _MainePageState createState() => _MainePageState();
}

class _MainePageState extends State<MainePage> {
  Firestore _positionInFireStore = Firestore.instance;
  Geoflutterfire geo = Geoflutterfire();
  Location location = Location();
  final usersRef = Firestore.instance.collection('users');
  final _auth = FirebaseAuth.instance;
  Filter selectedFilter;
  double latitude;
  double longitude;
  final trainingMateIFollowRef = Firestore.instance.collection(
      'Training Mate I follow');

  @override
  void initState() {
    super.initState();
    //function to delete old pos
    _addCurrentUserPosition();
    getCurrentUser();
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

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

// get users the collection location reference or query
  Stream<QuerySnapshot> getUsersStreamSnapshots(BuildContext context) async* {
    yield* Firestore.instance.collection('users').snapshots();
  }


  Stream<QuerySnapshot> getUsersWithSameSport(BuildContext context) async* {
    final uid = await Provider
        .of(context)
        .auth
        .getCurrentUID();
    final userSport = await Firestore.instance.document(uid)
        .collection('users').where('sport').getDocuments();

    yield* Firestore.instance
        .collection('users')
        .where("sport", isEqualTo: 'Football')
        .snapshots();
  }

  Stream<QuerySnapshot> currentUserStreamSnapshots(
      BuildContext context) async* {
    final uid = await Provider.of<CurrentUser>(context).getCurrentUID();
    yield* Firestore.instance.document(uid).collection('users').snapshots();
  }

  buildCurrentUserPic() {
    return FutureBuilder(
        future: Firestore.instance.collection('users').document(widget.currentUser.uid).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }
          OurPlayer user = OurPlayer.fromDocument(snapshot.data);
          return CircleAvatar(
            radius: 40.0,
            backgroundColor: Colors.grey,
            backgroundImage:
            CachedNetworkImageProvider(user.photoUrl),
          );
        });
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
                    buildCurrentUserPic(),
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          'assets/images/icon_new.png',
                          height: 50.0,
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
                          setState(() {
                            selectedFilter = Filter.sameSport;
                          });
                          Expanded(
                            child: StreamBuilder(
                                stream: getUsersWithSameSport(context),
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
                          ); //TODO implement filter
                        },
                        icon: Icons.fitness_center,
                      ),
                      ApRoundFilterButton(
                        title: 'My likes'.i18n,
                        onPressed: () {
                          setState(() {
                            selectedFilter = Filter.following;
                          });
                          print("filter like"); //TODO implement filter
                        },
                        icon: Icons.thumb_up,
                      ),
                      ApRoundFilterButton(
                        title: 'My coaches'.i18n,
                        onPressed: () {
                          setState(() {
                            selectedFilter = Filter.myCoach;
                          });
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
    floatingActionButton: FloatingActionButton(
    child: Icon(Icons.search),
    onPressed: () {
    Navigator.push(
    context, MaterialPageRoute(builder: (context) => Search()));
    },
    ),


      ),
    );
  }

  Widget buildUserCard(BuildContext context, DocumentSnapshot document) {
    final ourPlayer = OurPlayer.fromSnapshot(document);
    //current user can't see himself
    if (document['uid'] == loggedInUser.uid) {
      return Container();
      // }if (document['sport'] == widget.currentUser.sport) {
      //  return Container();
    }  else {
      return ApUserCard(
        name: ourPlayer.username,
        sport: ourPlayer.sport,
        level: ourPlayer.level,
        goal: ourPlayer.motivation,
        pic: ourPlayer.photoUrl,
        role: 'Player',
        //TODO get the role from database
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserDetails(ourPlayer: ourPlayer,),),
          );
        },
      );
    }
  }
}