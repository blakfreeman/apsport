import 'package:aptus/model/users.dart';
import 'package:aptus/services/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  final OurPlayer ourPlayer;

  UserDetails({Key key, @required this.ourPlayer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    ourPlayer.username,
                    style: TextStyle(
                        fontFamily: 'DM Sans', fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ourPlayer.age,
                    style: TextStyle(fontFamily: 'DM Sans'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ourPlayer.gender,
                    style: TextStyle(
                        fontFamily: 'DM Sans', fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ourPlayer.city,
                    style: TextStyle(
                        fontFamily: 'DM Sans', fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ourPlayer.sport,
                    style: TextStyle(
                        fontFamily: 'DM Sans', fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ourPlayer.level,
                    style: TextStyle(
                        fontFamily: 'DM Sans', fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ourPlayer.moment,
                    style: TextStyle(
                        fontFamily: 'DM Sans', fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ourPlayer.weekly,
                    style: TextStyle(
                        fontFamily: 'DM Sans', fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ourPlayer.motivation,
                    style: TextStyle(
                        fontFamily: 'DM Sans', fontWeight: FontWeight.w900),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: null,child: Icon(Icons.textsms), ),
    );
  }
}
