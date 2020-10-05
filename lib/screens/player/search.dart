import 'package:aptus/model/users.dart';
import 'package:aptus/screens/graphics/apUserCard.dart';
import 'package:aptus/screens/player/user_details.dart';
import 'package:aptus/services/constants.dart';
import 'package:aptus/services/data_base.dart';
import 'package:aptus/services/progress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aptus/screens/player/chat/chat_screen.dart';

FirebaseUser loggedInUser;

//search test working but not efficient enough
class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  Future<QuerySnapshot> searchResultsFuture;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  ///to add a possibility to convert the upercase and lowercase to a resulte anyway.
  handleSearch(String query) {
    Future<QuerySnapshot> users = Firestore.instance.collection('users')
        .where("sport", isEqualTo : query.trim()
    )
        .getDocuments();
    setState(() {
      searchResultsFuture = users;
    });
  }

  clearSearch() {
    searchController.clear();
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


  AppBar buildSearchField() {
    return AppBar(
      backgroundColor: Colors.purple,
      title: TextFormField(
        controller: searchController,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          fillColor: Colors.purple,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: "Search for a sport...",
          hintStyle: TextStyle(color: Colors.white),
          filled: true,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.white,
            ),
            onPressed: clearSearch,
          ),
        ),
        onFieldSubmitted: handleSearch,
      ),
    );
  }

  Container buildNoContent() {
    return Container(
      color: Colors.white,
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No Users",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    fontSize: 30.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildSearchResults() {
    return FutureBuilder(
      future: searchResultsFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        List<UserResult> searchResults = [];
        snapshot.data.documents.forEach((doc) {
          OurPlayer user = OurPlayer.fromDocument(doc);
          UserResult searchResult = UserResult(user);
          searchResults.add(searchResult);
        });
        return ListView(
          children: searchResults,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
      appBar: buildSearchField(),
      body:
      searchResultsFuture == null ? buildNoContent() : buildSearchResults(),
    );
  }
}

class UserResult extends StatelessWidget {
  final OurPlayer user;

  UserResult(this.user);

  @override
  Widget build(BuildContext context) {
    //current user can't see himself
    if (user.uid == loggedInUser.uid) {
      return Container();
    } else {
      return Container(
        color: Colors.white,
        child: ApUserCard(
          name: user.username,
          sport: user.sport,
          level: user.level,
          goal: user.motivation,
          pic: user.photoUrl,
          role: 'Player',
          //TODO get the role from database
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UserDetails(ourPlayer: user)),
            );
          },
        ),
      );
    }
  }
}


Widget buildUserCard(BuildContext context, DocumentSnapshot document) {
  final ourPlayer = OurPlayer.fromSnapshot(document);
  //current user can't see himself
  if (document['uid'] == currentUser.uid) {
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
              builder: (context) => UserDetails(ourPlayer: ourPlayer)),
        );
      },
    );
  }
}
