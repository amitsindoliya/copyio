import 'package:copyio/models/notes.dart';
import 'package:flutter/foundation.dart';

class Group {
  final String groupName;
  final String groupId;
  List<Notes> groupItems;

  Group({
    @required this.groupId,
    @required this.groupName,
    this.groupItems,
  });
}
