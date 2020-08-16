import 'package:aptus/model/users.dart';
import 'package:aptus/services/constants.dart';
import 'package:aptus/services/data_base.dart';
import 'package:aptus/services/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aptus/screens/player/chat/chat_screen.dart';


class UserDetails extends StatefulWidget {
  final OurPlayer ourPlayer;
  UserDetails({Key key, @required this.ourPlayer,}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  OurDatabase ourDatabase = OurDatabase();


  
  
  
  @override
  Widget build(BuildContext context,) {
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
      floatingActionButton: FloatingActionButton(onPressed:() { Navigator.push(context, MaterialPageRoute(
      builder: (context) => Chat(ourPlayer: ourPlayer
          ),),);}
    ,child: Icon(Icons.textsms), ),
    );
  }
}
