import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';



class Constants{

  static String myName = "";
}


const textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.white),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFFF0889B6), width: 2.0)),
);

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
const Color kHighlightAltColor = Color(0xFF152EB7);
const Color kDisabledColor = Color(0xFFAF9CD3);
const Color kDisabledAltColor = Color(0xFF8068BC);
const Color kLightestColor = Color(0xFFF5FAFF);
const Color kDarkestColor = Color(0xFF081040);
const Color kValidateColor = Color(0xFF29BF12);
const Color kErrorColor = Color(0xFFFF220C);
const Color kDarkGreen = Color(0xFF657B23);
const Color kElectricBlue = Color(0xFF046EE7);

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecorations = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white54),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
}

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.black, fontSize: 16);
}

TextStyle biggerTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 17);
}

final themeColor = Color(0xfff5a623);
final primaryColor = Color(0xff203152);
final greyColor = Color(0xffaeaeae);
final greyColor2 = Color(0xffE8E8E8);
