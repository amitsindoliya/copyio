import 'dart:convert';

import 'package:copyio/models/groups.dart';
import 'package:copyio/models/notes.dart';
import 'package:flutter/material.dart';
import './notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class GroupProvider with ChangeNotifier {
  // List<Notes> allNotes = gtNotes();
  List<Group> _groupsList = [
    Group(
      groupId: '1',
      groupName: 'All Notes',
    ),
  ];

  List<Group> get getGroups {
    return [..._groupsList];
  }

  void addGroup(String groupName) async {
    var url = Uri.https(
        'notescove-6c068-default-rtdb.firebaseio.com', '/groups.json');
    Map<String, Object> groupMap = {
      'groupName': groupName,
      'archived': 'no',
    };

    var response = await http.post(url, body: jsonEncode(groupMap));
    print(jsonDecode(response.body)['name']);
    _groupsList.add(Group(
        groupId: jsonDecode(response.body)['name'].toString(),
        groupName: groupName));
    notifyListeners();
  }

  void setAndFetchGroup() async {
    var url = Uri.https(
        'notescove-6c068-default-rtdb.firebaseio.com', '/groups.json');
    var response = await http.get(url);
    var decodedGroupMapList = jsonDecode(response.body);
    decodedGroupMapList.forEach((key, value) {
      Group newGroup = Group(groupId: key, groupName: value['groupName']);
      _groupsList.add(newGroup);
      notifyListeners();
    });
  }
}
