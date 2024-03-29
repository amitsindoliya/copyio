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
  String authToken;
  String authuserId;
  void update(String token, String userId) {
    authToken = token;
    authuserId = userId;
    if (token == null) {
      _groupsList = [
        Group(
          groupId: '1',
          groupName: 'All Notes',
        ),
      ];
    }
  }

  List<Group> get getGroups {
    return [..._groupsList];
  }

  Future<String> addGroup(String groupName) async {
    var params = {
      'auth': authToken,
    };
    var url = Uri.https('notescove-6c068-default-rtdb.firebaseio.com',
        '/$authuserId/groups.json', params);
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
    return jsonDecode(response.body)['name'].toString();
  }

  void setAndFetchGroup() async {
    var params = {
      'auth': authToken,
    };
    var url = Uri.https('notescove-6c068-default-rtdb.firebaseio.com',
        '/$authuserId/groups.json', params);
    var response = await http.get(url);
    var decodedGroupMapList = jsonDecode(response.body);
    decodedGroupMapList.forEach((key, value) {
      Group newGroup = Group(groupId: key, groupName: value['groupName']);
      _groupsList.add(newGroup);
      notifyListeners();
    });
  }
}
