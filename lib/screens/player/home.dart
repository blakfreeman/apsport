import 'package:aptus/screens/player/chat/chat_room.dart';
import 'package:aptus/screens/player/maine_page.dart';
import 'package:aptus/screens/player/user_profile.dart';
import 'package:aptus/services/constants.dart';
import 'package:aptus/services/current_user_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:aptus/screens/profile/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:aptus/screens/player/event.dart';
import 'package:aptus/screens/player/search.dart';
import 'package:aptus/model/users.dart';
import 'package:aptus/screens/player/chat/chat_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

OurPlayer currentUser;

class Home extends StatefulWidget {
  static const String id = 'home';
  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<Home> {
  PageController _pageController;
  int _page = 0;
  final usersRef = Firestore.instance.collection('users');



  OurPlayer currentUser;

getCurrentUser() async {
  final uid = await Provider.of<CurrentUser>(context, listen: false)
      .getCurrentUID();
  DocumentSnapshot doc = await usersRef.document(uid).get();
  currentUser = OurPlayer.fromDocument(doc);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[
          MainePage(currentUser : currentUser),
          //Search(),
          Event(),
          ChatScreen(),
          Profile(currentUser : currentUser),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: CupertinoTabBar(
            backgroundColor: kDarkestColor,
            onTap: navigationTapped,
            currentIndex: _page,
            activeColor: kForegroundColor,
            inactiveColor: kDisabledAltTransColor,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: _page == 0 ? 40 : 32,
                ),
              ),
              /*BottomNavigationBarItem(
                icon: Icon(Icons.search),
              ),*/
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.event,
                  size: _page == 1 ? 40 : 32,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  MdiIcons.chat,
                  size: _page == 2 ? 40 : 32,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: _page == 3 ? 40 : 32,
                ),
              ),
            ]),
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
