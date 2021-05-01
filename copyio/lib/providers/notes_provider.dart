import 'package:copyio/models/notes.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class NotesProvider with ChangeNotifier {
  List<Notes> _notesList = [
    Notes(
        id: '10',
        title: 'First Note',
        body: 'Tried to create the first note in the app'),
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
  ];

  List<Notes> get getNotes {
    return [..._notesList];
  }

  void setNotes(Notes note) {
    _notesList.add(note);
    notifyListeners();
  }
}
