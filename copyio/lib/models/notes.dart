import 'package:flutter/material.dart';

class Notes {
  final String id;
  final String title;
  final String body;
  Color color;
  bool isPinned;
  DateTime generatedTime;
  List<String> group;

  Notes(
      {@required this.id,
      this.title,
      this.body,
      this.color = const Color(0xFF82B1FF),
      this.isPinned = false,
      this.generatedTime,
      this.group});
}
