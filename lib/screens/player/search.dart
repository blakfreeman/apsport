import 'package:aptus/model/users.dart';
import 'package:aptus/services/progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Search extends StatefulWidget {
  static const String id = 'search';

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with AutomaticKeepAliveClientMixin<Search>
 {
  TextEditingController searchController = TextEditingController();
  Future<QuerySnapshot> searchResultsFuture;

  sportSearch(String str) {
    Future<QuerySnapshot> allUsers = Firestore.instance
        .collection('users')
        .where('sport', isGreaterThanOrEqualTo: str)
        .getDocuments();
    setState(() {
      searchResultsFuture = allUsers;
    });
  }

  clearSearch() {
    searchController.clear();
  }


//Due to a bug or maybe I don't understand it well enough, It seams that I can't align the on the top left and top right my icons, so I remove them for now (temporally)
  AppBar buildSearchField() {
    return AppBar(automaticallyImplyLeading: false,backgroundColor: Colors.blueAccent,title:

     TextFormField(
        controller: searchController,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(fillColor: Colors.blueAccent,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: "Search for a sport...",
          hintStyle: TextStyle(color: Colors.white),
          filled: true,
          prefixIcon: Icon(Icons.search,color: Colors.white,),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear,
            color: Colors.white,),
            onPressed: clearSearch,
          ),
        ),
        onFieldSubmitted: sportSearch,
      ),
    );
  }




  Container buildNoContent() {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Column(children: <Widget>[
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
            ],),

          ],
        ),
      ),
    );
  }

  buildSearchResults() {
    return FutureBuilder(
      future: searchResultsFuture,
      builder: (context, dataSnapshot) {
        if (!dataSnapshot.hasData) {
          return circularProgress();
        }
        List<UserResult> searchResults = [];
        dataSnapshot.data.documents.forEach((document) {
          OurPlayer eachUser = OurPlayer.fromDocument(document);
          UserResult userResult = UserResult(eachUser);
          searchResults.add(userResult);
        });
        return ListView(
          children: searchResults,
        );
      },
    );
  }


  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
    appBar: buildSearchField(),
        body: searchResultsFuture == null
        ? buildNoContent()
        : buildSearchResults(),
    );
  }
}

class UserResult extends StatelessWidget {
  final OurPlayer eachUser;
  UserResult(this.eachUser);
  @override
  Widget build(BuildContext context) {
    return Container(
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
