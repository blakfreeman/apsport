import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:aptus/services/constants.dart';

class ApDropdownButtonFormField extends StatelessWidget {
  ApDropdownButtonFormField(
      {@required this.items,
      @required this.onChanged,
      this.hintText,
      this.value,
      this.validator});
  final List<DropdownMenuItem<String>> items;
  final FormFieldSetter<String> onChanged;
  final String hintText;
  final String value;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      //style: TextStyle(color: kForegroundColor),
      items: items,
      onChanged: onChanged,
      //value: value,
      validator: validator,
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: TextStyle(color: kHighlightColor),
        hintText: hintText,
        hintStyle: TextStyle(color: kForegroundColor),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kHighlightColor)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kForegroundColor)),
      ),
      iconEnabledColor: kHighlightColor,
      isExpanded: true,
      selectedItemBuilder: (BuildContext context) {
        return items.map((DropdownMenuItem value) {
          return Text(
            value.value,
            style: TextStyle(color: kForegroundColor),
          );
        }).toList();
      },
    );
  }
}
