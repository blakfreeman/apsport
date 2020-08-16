import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

const Color kBackgroundColor = Color(0xFF000841);
const Color kForegroundColor = Color(0xFFE0E4FF);
const Color kHighlightColor = Color(0xFF8A95FF);
const Color kDisabledColor = Color(0xFFAF9CD3);
const Color kDarkestColor = Color(0xFF081040);
const Color kValidateColor = Color(0xFF29BF12);
const Color kErrorColor = Color(0xFFFF220C);
