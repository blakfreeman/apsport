import 'package:flutter/material.dart';
import 'package:aptus/services/constants.dart';

class ApRoundedButtonLarge extends StatelessWidget {
  ApRoundedButtonLarge({this.title, @required this.onPressed});

  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 1.0,
        color: kForegroundColor,
        borderRadius: BorderRadius.circular(20.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 270.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 20.0,
              color: kBackgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
