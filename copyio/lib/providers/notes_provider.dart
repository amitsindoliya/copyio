import 'package:copyio/models/groups.dart';
import 'package:copyio/models/notes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotesProvider with ChangeNotifier {
  List<Notes> _notesList = [
    Notes(
        id: '10',
        title: 'First Note',
        body: 'Tried to create the first note in the app',
        color: Colors.red[100],
        group: ['1', '2'],
        generatedTime: DateTime.now()),
    Notes(
        id: '11',
        title: 'First Note123',
        body:
            'Tried to create the first note in the app ddddddd Tried to create the first note in the app ddddddd Tried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app ddddddd',
        group: ['1', '3'],
        generatedTime: DateTime.now()),
    Notes(
        id: '12',
        title: 'First Note789',
        body: 'Tried to create the first note in the app fsjdsd',
        group: ['1', '3'],
        generatedTime: DateTime.now()),
    Notes(
        id: '13',
        title: 'First Note8',
        body: 'Tried to create the first note in the app sfdnfds',
        group: ['1', '2'],
        generatedTime: DateTime.now()),
    Notes(
        id: '14',
        title: 'First Note4',
        body: 'Tried to create the first note in the app jbdjxb',
        group: ['1', '3'],
        generatedTime: DateTime.now()),
    Notes(
        id: '15',
        title: 'First Note4',
        body: 'Tried to create the first note in the app dfsbfbs',
        group: ['1', '2'],
        generatedTime: DateTime.now()),
    Notes(
        id: '16',
        title: 'First Note55',
        body: 'Tried to create the first note in the appefrf',
        group: ['1', '3'],
        generatedTime: DateTime.now())
  ];
  int pinnedCompare(Notes a, Notes b) {
    if ((a.isPinned && b.isPinned) ||
        (a.isPinned == false && b.isPinned == false)) {
      return -a.generatedTime.compareTo(b.generatedTime);
    } else if (a.isPinned && b.isPinned == false) {
      return -1;
    } else {
      return 1;
    }
  }

  List<Notes> get getNotes {
    _notesList.sort((a, b) => pinnedCompare(a, b));
    return [..._notesList];
  }

  List<Notes> getGroup(String id) {
    // print('***' + id);
    List<Notes> notesGroup = _notesList
        .where(
          (element) => element.group.contains(id),
        )
        .toList();
    // print(notesGroup);
    return notesGroup;
  }

  void addToGroup(Notes note) {
    notifyListeners();
  }

  void setNotes(Notes note) {
    print(note.group);
    _notesList.insert(0, note);
    // print(_notesList);
    notifyListeners();
  }

  void changeById(Notes note) {
    print('---' + note.isPinned.toString());
    int updateIndex = _notesList.indexWhere((oldnote) => oldnote.id == note.id);
    _notesList[updateIndex] = note;

    notifyListeners();
  }

  Notes findById(Notes note) {
    Notes noteData = _notesList.firstWhere((element) => element.id == note.id);
    return noteData;
  }

  List<Notes> get getRecentNotes {
    var nlist = [..._notesList];
    var sortedList =
        nlist.sort((a, b) => a.generatedTime.compareTo(b.generatedTime));
  }

  void pinNote(String id) {
    int ind = _notesList.indexWhere((element) => element.id == id);
    _notesList[ind].isPinned = !_notesList[ind].isPinned;

    notifyListeners();
  }

  void deleteById(String id) {
    _notesList.removeWhere((element) => element.id == id);
    // _notesList[ind].isPinned = !_notesList[ind].isPinned;
    notifyListeners();
  }
}
