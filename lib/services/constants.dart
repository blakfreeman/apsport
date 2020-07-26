import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Constants{

  static String myName = "";
}

const kTextFieldDecoration = InputDecoration(
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
      width: 2.0,
    ),
  ),
  hintText: 'Enter a value',
  hintStyle: TextStyle(
      color: Colors.white70,
      fontSize: 15.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'DM Sans'),
  contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
);

const kLabelTextStyle = TextStyle(
  fontSize: 15.0,
  color: Colors.white,
);

const kActiveCardColour = Color(0xFFFDB927);
const kInactiveCardColour = Color(0xFFC4C4C4);
const kBottomContainerHeight = 80.0;
const kBottomContainerColour = Color(0xFFFDB927);
const kLargeButtonTextStyle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
);
