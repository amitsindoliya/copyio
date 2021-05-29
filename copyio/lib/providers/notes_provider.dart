import 'dart:convert';
import 'dart:ffi';

import 'package:copyio/models/groups.dart';
import 'package:copyio/models/notes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotesProvider with ChangeNotifier {
  List<Notes> _notesList = [
    // Notes(
    //     id: '10',
    //     title: 'First Note',
    //     body: 'Tried to create the first note in the app',
    //     color: Colors.red[100],
    //     group: ['1', '2'],
    //     generatedTime: DateTime.now()),
    // Notes(
    //     id: '11',
    //     title: 'First Note123',
    //     body:
    //         'Tried to create the first note in the app ddddddd Tried to create the first note in the app ddddddd Tried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app dddddddTried to create the first note in the app ddddddd',
    //     group: ['1', '3'],
    //     generatedTime: DateTime.now()),
    // Notes(
    //     id: '12',
    //     title: 'First Note789',
    //     body: 'Tried to create the first note in the app fsjdsd',
    //     group: ['1', '3'],
    //     generatedTime: DateTime.now()),
    // Notes(
    //     id: '13',
    //     title: 'First Note8',
    //     body: 'Tried to create the first note in the app sfdnfds',
    //     group: ['1', '2'],
    //     generatedTime: DateTime.now()),
    // Notes(
    //     id: '14',
    //     title: 'First Note4',
    //     body: 'Tried to create the first note in the app jbdjxb',
    //     group: ['1', '3'],
    //     generatedTime: DateTime.now()),
    // Notes(
    //     id: '15',
    //     title: 'First Note4',
    //     body: 'Tried to create the first note in the app dfsbfbs',
    //     group: ['1', '2'],
    //     generatedTime: DateTime.now()),
    // Notes(
    //     id: '16',
    //     title: 'First Note55',
    //     body: 'Tried to create the first note in the appefrf',
    //     group: ['1', '3'],
    //     generatedTime: DateTime.now())
  ];

  String authToken;
  String authuserId;
  void update(String token, String userId) {
    authToken = token;
    authuserId = userId;
    if (token == null) {
      _notesList = [];
    }
  }

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

  Future<void> getDataFromServer() async {
    var params = {
      'auth': authToken,
    };
    var url = Uri.https('notescove-6c068-default-rtdb.firebaseio.com',
        '/$authuserId/notes.json', params);
    var response = await http.get(url);
    var decodedServerData = jsonDecode(response.body);
    // print(decodedServerData);
    decodedServerData.forEach((key, value) {
      Notes note = Notes(
        id: key,
        title: value['title'],
        color: Color(value['color']),
        body: value['body'],
        generatedTime: DateTime.parse(value['generatedTime']),
        group: value['group'].cast<String>(),
        isPinned: value['pinned'],
      );
      _notesList.add(note);
      notifyListeners();
    });
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

  void changeGroupDetails(String id, String gId) {
    _notesList.firstWhere((element) => element.id == id).group.remove(gId);
    notifyListeners();
  }

  void addToGroup(Notes note, String gId) {
    var params = {
      'auth': authToken,
    };
    var url = Uri.https('notescove-6c068-default-rtdb.firebaseio.com',
        '/$authuserId/notes/${note.id}.json', params);
    if (_notesList
        .firstWhere((element) => element.id == note.id)
        .group
        .contains(gId)) {
    } else {
      _notesList.firstWhere((element) => element.id == note.id).group.add(gId);
      http.patch(url,
          body: jsonEncode({
            'group':
                _notesList.firstWhere((element) => element.id == note.id).group
          }));
    }
    notifyListeners();
  }

  Future<void> setNotes(Notes note) async {
    var params = {
      'auth': authToken,
    };
    var url = Uri.https('notescove-6c068-default-rtdb.firebaseio.com',
        '/$authuserId/notes.json', params);
    Map<String, Object> noteMap = {
      'title': note.title,
      'body': note.body,
      'color': note.color.value,
      'generatedTime': note.generatedTime.toString(),
      'pinned': note.isPinned,
      'group': note.group
    };
    var response = await http.post(url, body: jsonEncode(noteMap));
    var id = jsonDecode(response.body)['name'];
    Notes newNote = Notes(
        id: id.toString(),
        title: note.title,
        body: note.body,
        color: note.color,
        generatedTime: note.generatedTime,
        isPinned: note.isPinned,
        group: note.group);
    _notesList.insert(0, newNote);
    notifyListeners();

    // print(response);

    // print(_notesList);
  }

  void changeById(Notes note) async {
    // print('---' + note.isPinned.toString());
    var params = {
      'auth': authToken,
    };
    var url = Uri.https('notescove-6c068-default-rtdb.firebaseio.com',
        '/$authuserId/notes/${note.id}.json', params);
    int updateIndex = _notesList.indexWhere((oldnote) => oldnote.id == note.id);
    Map<String, Object> updatedNoteMap = {
      'title': note.title,
      'body': note.body,
      'color': note.color.value,
      'generatedTime': note.generatedTime.toString(),
      'pinned': note.isPinned,
      'group': note.group
    };
    await http.patch(url, body: jsonEncode(updatedNoteMap));
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
    var params = {
      'auth': authToken,
    };
    var url = Uri.https('notescove-6c068-default-rtdb.firebaseio.com',
        '/$authuserId/notes/$id.json', params);
    int ind = _notesList.indexWhere((element) => element.id == id);
    _notesList[ind].isPinned = !_notesList[ind].isPinned;
    http.patch(url,
        body: jsonEncode({
          'pinned': _notesList[ind].isPinned,
        }));
    notifyListeners();
  }

  void deleteById(String id) {
    var params = {
      'auth': authToken,
    };
    var url = Uri.https('notescove-6c068-default-rtdb.firebaseio.com',
        '/$authuserId/notes/$id.json', params);
    _notesList.removeWhere((element) => element.id == id);
    http.delete(url);
    // _notesList[ind].isPinned = !_notesList[ind].isPinned;
    notifyListeners();
  }
}
