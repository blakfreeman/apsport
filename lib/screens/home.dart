import 'package:flutter/cupertino.dart';
import 'package:aptus/screens/event.dart';
import 'package:aptus/screens/near_me.dart';
import 'package:flutter/material.dart';
import 'package:aptus/screens/search.dart';
import 'package:aptus/screens/edit_profile.dart';
import 'package:aptus/screens/chat.dart';

class Home extends StatefulWidget {
  static const String id = 'home';
  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<Home> {
  PageController _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[
          NearMe(),
          Search(),
          Event(),
          Chat(),
          EditProfile(),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
          onTap: navigationTapped,
          currentIndex: _page,
          activeColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.near_me),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.event,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
            ),
          ]),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
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
