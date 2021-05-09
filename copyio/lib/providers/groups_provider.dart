import 'package:copyio/models/groups.dart';
import 'package:copyio/models/notes.dart';
import 'package:flutter/material.dart';
import './notes_provider.dart';
import 'package:provider/provider.dart';

class GroupProvider with ChangeNotifier {
  // List<Notes> allNotes = gtNotes();
  List<Group> _groupsList = [
    Group(
      groupId: '1',
      groupName: 'All Notes',
    ),
    Group(
      groupId: '2',
      groupName: 'Home',
    ),
    Group(
      groupId: '3',
      groupName: 'Work',
    ),
  ];

  List<Group> get getGroups {
    return [..._groupsList];
  }
}
