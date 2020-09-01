import 'package:aptus/model/users.dart';
import 'package:aptus/services/constants.dart';
import 'package:aptus/services/current_user_auth.dart';
import 'package:aptus/services/data_base.dart';
import 'package:aptus/services/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aptus/screens/player/chat/chat_screen.dart';
import 'package:provider/provider.dart';

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


  sendMessage() async{
    final currentUserEmail = await Provider.of<CurrentUser>(context, listen: false).getCurrentEmail();
    List<String> users = [currentUserEmail,widget.ourPlayer.email];

    String chatRoomId = getChatRoomId(currentUserEmail,widget.ourPlayer.email);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId" : chatRoomId,
    };

    ourDatabase.addChatRoom(chatRoom, chatRoomId);

    Navigator.push(context, MaterialPageRoute(
        builder: (context) => Chat(
          chatRoomId: chatRoomId,ourPlayer: widget.ourPlayer, currentUserEmail: currentUserEmail ,
        )
    ));

  }
  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }



  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Details'),
              backgroundColor: Colors.blueAccent,
              expandedHeight: 350.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset('assets/images/anthony.jpg'),
              ),
            ),
            SliverFixedExtentList(
              itemExtent: 60.00,
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.ourPlayer.username,
                    style: TextStyle(
                        fontFamily: 'DM Sans', fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.ourPlayer.age,
                    style: TextStyle(fontFamily: 'DM Sans'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.ourPlayer.gender,
                    style: TextStyle(
                        fontFamily: 'DM Sans', fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.ourPlayer.city,
                    style: TextStyle(
                        fontFamily: 'DM Sans', fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.ourPlayer.sport,
                    style: TextStyle(
                        fontFamily: 'DM Sans', fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.ourPlayer.level,
                    style: TextStyle(
                        fontFamily: 'DM Sans', fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.ourPlayer.moment,
                    style: TextStyle(
                        fontFamily: 'DM Sans', fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.ourPlayer.weekly,
                    style: TextStyle(
                        fontFamily: 'DM Sans', fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.ourPlayer.motivation,
                    style: TextStyle(
                        fontFamily: 'DM Sans', fontWeight: FontWeight.w900),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { sendMessage();
        },
        child: Icon(Icons.textsms),
      ),
    );
  }
}
