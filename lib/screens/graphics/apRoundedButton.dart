import 'package:flutter/material.dart';
import 'package:aptus/services/constants.dart';

class ApRoundedButton extends StatelessWidget {
  ApRoundedButton({this.title, this.colour, @required this.onPressed});

  final Color colour;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 1.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 100.0,
          height: 42.0,
          highlightColor: kDisabledColor,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kBackgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
