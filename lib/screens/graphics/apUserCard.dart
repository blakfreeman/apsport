import 'package:flutter/material.dart';
import 'package:aptus/services/constants.dart';

class ApUserCard extends StatelessWidget {
  ApUserCard(
      {this.name,
      this.sport,
      this.level,
      this.goal,
      this.role,
      this.pic,
      this.onTap});

  final String name;
  final String sport;
  final String level;
  final String goal;
  final String role;
  final String pic;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: kLightestColor,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            ClipRRect(
              //borderRadius: BorderRadius.circular(20.0),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              ),
              child: Image.asset(
                pic,
                width: 100,
                height: 100,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: new TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 24.0,
                      color: kBackgroundColor,
                    ),
                  ),
                  Text(
                    sport + ', ' + level,
                    style: new TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16.0,
                      color: kBackgroundColor,
                    ),
                  ),
                  Text(
                    goal,
                    style: new TextStyle(
                      fontFamily: 'Roboto Light Italic',
                      fontSize: 16.0,
                      color: kHighlightAltColor,
                    ),
                  ),
                  Text(
                    role,
                    style: new TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16.0,
                      color: role == 'Player' ? kDarkGreen : kElectricBlue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
