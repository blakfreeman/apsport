import 'package:flutter/material.dart';
import 'package:aptus/services/constants.dart';

class ApRoundFilterButton extends StatefulWidget {
  ApRoundFilterButton(
      {this.title, this.colour, this.icon, @required this.onPressed});

  final Color colour;
  final String title;
  final IconData icon;
  final Function onPressed;

  @override
  _ApRoundFilterButtonState createState() => _ApRoundFilterButtonState(
      colour: colour, title: title, icon: icon, onPressed: onPressed);
}

class _ApRoundFilterButtonState extends State<ApRoundFilterButton> {
  _ApRoundFilterButtonState(
      {this.title, this.colour, this.icon, @required this.onPressed});

  final Color colour;
  final String title;
  final IconData icon;
  final Function onPressed;
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Material(
        //elevation: 1.0,
        //color: colour,
        //borderRadius: BorderRadius.circular(30.0),
        child: FlatButton(
          onPressed: onPressed,
          //minWidth: 100.0,
          //height: 42.0,
          //highlightColor: kDisabledColor,
          child: Column(
            children: [
              FilterChip(
                selected: _selected,
                showCheckmark: false,
                backgroundColor: _selected ? kHighlightColor : kLightestColor,
                selectedColor: kForegroundColor,
                label: Container(
                  height: 50,
                  width: 50,
                  child: Center(
                    child: Icon(
                      icon,
                      color: _selected ? kDarkestColor : kDisabledAltColor,
                      size: _selected ? 28.0 : 24.0,
                    ),
                  ),
                ),
                shape: new CircleBorder(
                  side: BorderSide(
                      color: _selected ? kHighlightColor : kDisabledColor,
                      width: _selected ? 2 : 1,
                      style: BorderStyle.solid),
                ),
                onSelected: (bool selected) {
                  setState(() {
                    _selected = !_selected;
                  });
                },
              ),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16.0,
                  color: kBackgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
