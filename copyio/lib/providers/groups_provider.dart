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
      groupItems: [
        Notes(
            id: '10',
            title: 'First Note',
            body: 'Tried to create the first note in the app',
            color: Colors.red[100]),
        Notes(
            id: '11',
            title: 'First Note123',
            body:
                'Tried to create the first note in the app ddddddd Tried to create the first note in the app ddddddd Tried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app ddddddd'),
        Notes(
            id: '12',
            title: 'First Note789',
            body: 'Tried to create the first note in the app fsjdsd'),
        Notes(
            id: '13',
            title: 'First Note8',
            body: 'Tried to create the first note in the app sfdnfds'),
        Notes(
            id: '14',
            title: 'First Note4',
            body: 'Tried to create the first note in the app jbdjxb'),
        Notes(
            id: '15',
            title: 'First Note4',
            body: 'Tried to create the first note in the app dfsbfbs'),
        Notes(
            id: '16',
            title: 'First Note55',
            body: 'Tried to create the first note in the appefrf')
      ],
    ),
    Group(
      groupId: '2',
      groupName: 'imp-Notes',
      groupItems: [
        Notes(
            id: '16',
            title: 'First Note55',
            body: 'Tried to create the first note in the appefrf'),
      ],
    ),
  ];

  List<Group> get getGroups {
    return [..._groupsList];
  }
}
