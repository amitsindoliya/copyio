import 'package:copyio/models/groups.dart';
import 'package:copyio/models/notes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupProvider with ChangeNotifier {
  List<Group> _groupsList = [
    Group(groupId: '1', groupName: 'All Notes', groupItems: []),
    Group(groupId: '2', groupName: 'imp-Notes', groupItems: []),
  ];
}
