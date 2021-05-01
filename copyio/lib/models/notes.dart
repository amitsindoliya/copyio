import 'package:flutter/material.dart';

class Notes {
  final String id;
  final String title;
  final String body;

  Notes({
    @required this.id,
    this.title,
    this.body,
  });
}
