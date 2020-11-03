import 'package:aptus/model/users.dart';
import 'package:aptus/services/constants.dart';
import 'package:aptus/services/current_user_auth.dart';
import 'package:aptus/services/data_base.dart';
import 'package:aptus/services/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aptus/screens/player/chat/chat_screen.dart';
import 'package:provider/provider.dart';
import 'package:aptus/screens/player/user_details.i18n.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//import 'package:aptus/screens/sign_up/sign_up.i18n.dart';
//import 'package:aptus/services/list.i18n.dart';

class UserDetails extends StatefulWidget {
  final OurPlayer ourPlayer;
  UserDetails({
    Key key,
    @required this.ourPlayer,
  }) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  OurDatabase ourDatabase = OurDatabase();


  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/background_3.jpg'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: kDarkestColor, //change your color here
          ),
          elevation: 0,
          title: Text(
            'Player Profile',
            style: TextStyle(
                color: kDarkGreen, fontSize: 20.0, fontFamily: 'Roboto'),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          //scrollDirection: Axis.horizontal,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  FadeInImage(
                    image: widget.ourPlayer.photoUrl == null
                        ? AssetImage('assets/images/user.jpg')
                        : NetworkImage(widget.ourPlayer.photoUrl),
                    width: 320,
                    height: 180,
                    placeholder: AssetImage('assets/images/icon_new.png'),
                  ),
                  Center(
                    child: Text(
                      widget.ourPlayer.username + ", " + widget.ourPlayer.city,
                      style: TextStyle(
                          fontFamily: 'Roboto Bold',
                          fontSize: 24.0,
                          color: kDarkestColor),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.ourPlayer.age + " " + "years old".i18n,
                style: TextStyle(
                    fontFamily: 'Roboto', fontSize: 18, color: kDarkestColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.ourPlayer.gender == 'Male'
                        ? MdiIcons.genderMale
                        : widget.ourPlayer.gender == 'Female'
                            ? MdiIcons.genderFemale
                            : MdiIcons.genderNonBinary,
                    size: 24,
                  ),
                  Text(
                    widget.ourPlayer.gender,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                        color: kDarkestColor),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.ourPlayer.sport + ", " + widget.ourPlayer.level,
                style: TextStyle(
                    fontFamily: 'Roboto', fontSize: 18, color: kDarkestColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Motivation:".i18n + " " + widget.ourPlayer.motivation,
                style: TextStyle(
                    fontFamily: 'Roboto Light Italic',
                    fontSize: 18,
                    color: kHighlightAltColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    MdiIcons.calendarBlank,
                    size: 24,
                    color: kDarkestColor,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    widget.ourPlayer.weekly + ", " + widget.ourPlayer.moment,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                        color: kDarkestColor),
                  ),
                ],
              ),
            ),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kDarkestColor,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      receiver: widget.ourPlayer,
                    )));
          },
          child: Icon(
            MdiIcons.chat,
            size: 24,
            color: kForegroundColor,
          ),
        ),
      ),
    );
  }
}
