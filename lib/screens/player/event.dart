import 'package:aptus/services/widget.dart';
import 'package:flutter/material.dart';

class Event extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, isAppTitle: false, titleText: 'EVENT'),
    );
  }
}
