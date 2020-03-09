import 'package:aptus/screens/edit_profile.dart';
import 'package:aptus/screens/near_me.dart';
import 'package:aptus/screens/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:aptus/screens/event.dart';
import 'package:aptus/screens/chat.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:aptus/services/components.dart';
import 'package:aptus/services/constants.dart';
import 'package:aptus/screens/registration.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aptus/users/users.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);
final StorageReference storageRef = FirebaseStorage.instance.ref();
final usersRef = Firestore.instance.collection('Player');
final DateTime timestamp = DateTime.now();
User currentUser;

class Home extends StatefulWidget {
  static const String id = 'home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isAuth = false;
  PageController pageController;
  int pageIndex = 0;
  String email;
  String password;
  final _auth = FirebaseAuth.instance;

  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    // Detects when user signed in
    _googleSignIn.onCurrentUserChanged.listen((account) {
      _handleSignIn();
    }, onError: (err) {
      print('Error signing in: $err');
    });
    // Reauthenticate user when app is opened
    _googleSignIn.signInSilently(suppressErrors: false).then((account) {
      _handleSignIn();
    }).catchError((err) {
      print('Error signing in: $err');
    });
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  createUserInFireStore() async {
    // 1) check if user exists in users collection in database (according to their id)
    final GoogleSignInAccount user = _googleSignIn.currentUser;
    DocumentSnapshot doc = await usersRef.document(user.id).get();

    if (!doc.exists) {
      // 2) if the user doesn't exist, then we want to take them to the create account page
      final username =
          await Navigator.pushNamed(context, RegistrationScreen.id);

      // 3) get username from create account, use it to make new user document in users collection
      usersRef.document(user.id).setData({
        "id": user.id,
        "username": username,
        "photoUrl": user.photoUrl,
        "email": user.email,
        "displayName": user.displayName,
        "bio": "",
        "timestamp": timestamp
      });

      doc = await usersRef.document(user.id).get();
    }

    currentUser = User.fromDocument(doc);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  login() {
    _googleSignIn.signIn();
  }

  logout() {
    _googleSignIn.signOut();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  Scaffold buildAuthScreen() {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          NearMe(),
          Search(),
          Event(),
          Chat(),
          EditProfile(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
    );
  }

  Widget buildUnAuthScreen() {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bleu_image.png'),
                fit: BoxFit.cover),
          ),
          constraints: BoxConstraints(),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    'assets/images/Aptus_white.png',
                    height: 55.0,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(35.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'APTUS ',
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.bold,
                            fontSize: 50.0,
                            color: Colors.white),
                      ),
                      Text(
                        '                         MEET AND PLAY ',
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 90.0,
                      ),
                      TextField(
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.left,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            icon: Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            hintText: 'Enter your email'),
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 2.0,
                      ),
                      TextField(
                        style: TextStyle(color: Colors.white),
                        obscureText: true,
                        textAlign: TextAlign.left,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            icon: Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                            hintText: 'Password'),
                      ),
                      Divider(
                        color: Colors.white,
                        thickness: 2.0,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 50.0, right: 50.0),
                        child: Text(
                          "Pleas sign up if you don't have any account",
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'DM Sans'),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          RoundedButton(
                            title: 'Login',
                            colour: Color(0xFF542581),
                            onPressed: () async {
                              setState(() {
                                showSpinner = true;
                              });
                              try {
                                final user =
                                    await _auth.signInWithEmailAndPassword(
                                        email: email, password: password);
                                if (user != null) {
                                  setState(() {
                                    _isAuth = true;
                                    return buildAuthScreen();
                                  });
                                }

                                setState(() {
                                  showSpinner = false;
                                });
                              } catch (e) {
                                print(e);
                              }
                            },
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          RoundedButton(
                            title: 'Register',
                            colour: Colors.blueAccent,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RegistrationScreen.id);
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: login,
                            child: Container(
                              width: 50,
                              height: 60,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/icons8-google-48.png'),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15.0),
                          GestureDetector(
                            child: Container(
                              width: 50,
                              height: 60,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/icons8-facebook-circled-48.png'),
                                ),
                              ),
                            ),
                          ),
                        ],
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

  @override
  Widget build(BuildContext context) {
    return _isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}

//decoration: BoxDecoration(
//gradient: LinearGradient(
//begin: Alignment.topRight,
//end: Alignment.bottomLeft,
//colors: [
//Colors.white,
//Colors.white,
//Color(0xFF542581),
//Colors.blueAccent,
// ],
//),

// backgroundColor: Colors.white,
//body: Container(
//child: Column(
//mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.stretch,
//children: <Widget>[
//SizedBox(
//height: 20.0,
//),
//Image.asset(
//'assets/images/AptusP_G.png',
//height: 90,
//),
// Text(
//'APTUS',
//textAlign: TextAlign.center,
// style: TextStyle(
// fontWeight: FontWeight.bold,
//fontFamily: 'DM Sans',
//fontSize: 25.0,
//color: Colors.black,
//),
//),
//Text(
//'                 Meet and Plays',
//textAlign: TextAlign.center,
//style: TextStyle(
//fontFamily: 'DM Sans',
//fontSize: 10.0,
//color: Colors.black,
//),
//),
//],
//),
//),
//);
