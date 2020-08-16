import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:aptus/services/constants.dart';

class ApTextFormField extends StatelessWidget {
  ApTextFormField(
      {@required this.onChanged,
      @required this.validator,
      @required this.controller,
      @required this.hintText,
      this.type,
      this.obscureText});
  final FormFieldSetter<String> onChanged;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final String hintText;
  final TextInputType type;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: kForegroundColor),
      onChanged: onChanged,
      controller: controller,
      keyboardType: type,
      validator: validator,
      textInputAction: TextInputAction.next,
      decoration: kTextFieldDecoration.copyWith(
        hintText: hintText,
        hintStyle: TextStyle(color: kForegroundColor),
        labelText: hintText,
        labelStyle: TextStyle(color: kHighlightColor),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kHighlightColor)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: kForegroundColor),
        ),
      ),
      obscureText: obscureText,
    );
  }
}
