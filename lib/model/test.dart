import 'package:aptus/model/users.dart';
import 'package:aptus/screens/player/user_details.dart';
import 'package:aptus/services/constants.dart';
import 'package:aptus/services/data_base.dart';
import 'package:aptus/services/progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aptus/screens/player/chat/chat_screen.dart';


//search test working but not efficient enough
class Search extends StatefulWidget {
  static const String id = 'search';

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with AutomaticKeepAliveClientMixin<Search>
{
  TextEditingController searchController = TextEditingController();
  Future<QuerySnapshot> searchResultsFuture;
  OurDatabase databaseMethods =  OurDatabase();
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


  ///what we will use to show the results
  Widget buildUserCard(BuildContext context, DocumentSnapshot document) {
    final ourPlayer = OurPlayer.fromSnapshot(document);
    return new Container(
      width: 200,
      child: Card(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        color: Colors.white,
        child: InkWell(
          onTap:  null,
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.center,child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(ourPlayer.username, style: new TextStyle(fontSize: 20.0),),
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
                                  fontSize: 15.0, fontWeight: FontWeight.w900,),
                              ),
                            ),
                          ),
                        ),

                        Align(
                            alignment: Alignment.centerLeft,child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(ourPlayer.level, style: new TextStyle(fontSize: 15.0),),
                        )),
                      ],
                    ),
                    Align( alignment: Alignment.centerLeft,child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        ourPlayer.motivation,
                        style: new TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w900,),
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








  bool get wantKeepAlive => true;
  @override
  // ignore: must_call_super
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


///test version of the results
class UserResult extends StatelessWidget {
  final OurPlayer eachUser;

  UserResult(this.eachUser);




  @override
  Widget build(BuildContext context) {

    return Container(
      width: 200,
      child: Card(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        color: Colors.white,
        child: InkWell(
          onTap:  () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UserDetails(ourPlayer: eachUser)),);},
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.center,child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(eachUser.username, style: new TextStyle(fontSize: 20.0),),
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
                                eachUser.sport,
                                style: new TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.w900,),
                              ),
                            ),
                          ),
                        ),

                        Align(
                            alignment: Alignment.centerLeft,child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(eachUser.level, style: new TextStyle(fontSize: 15.0),),
                        )),
                      ],
                    ),
                    Align( alignment: Alignment.centerLeft,child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        eachUser.motivation,
                        style: new TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w900,),
                      ),
                    ),
                    ),],

                ),
                Spacer(),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(24)
                    ),
                    child: Text("Message",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                      ),),
                  ),
                )

              ],
            ),

          ),
        ),
      ),
    );
  }
}
