import 'package:flutter/material.dart';

class Activity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
            'Sorry, This page isn\'t available in the current release. Stick around for the next update.',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400)),
      ),
    );
  }
}
