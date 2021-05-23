import 'package:copyio/models/notes.dart';
import 'package:copyio/providers/groups_provider.dart';
import 'package:copyio/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notes_detail.dart';
import 'dart:math';

enum Department {
  treasury,
  state,
}

class NotesCard extends StatelessWidget {
  final Notes notes;
  final double height;
  final bool isFullWidth;
  final String gId;

  NotesCard(
    this.notes,
    this.height,
    this.isFullWidth,
    this.gId,
  );

  notesPageNavigator(BuildContext context, title, body) {
    return Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NotesDetail(
              notes.id,
              title,
              body,
              notes.generatedTime,
              notes.color,
              notes.group,
              notes.isPinned,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          child: Container(
            // color: Colors.teal[200],
            width: isFullWidth
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width * 0.4,

            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: height * 0.1,
                  // width: 100,
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Text(
                    notes.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                    // height: height * 0.7,
                    child: Text(
                      notes.body,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: notes.color,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[350],
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ],
            ),
          ),
          onTap: () {
            notesPageNavigator(context, notes.title, notes.body);
          },
          onLongPress: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  children: [
                    ModalPins('Pin', Icons.push_pin_outlined, notes, gId),
                    ModalPins('Delete', Icons.delete_outline, notes, gId),
                    ModalPins('Add to Another Group', Icons.add, notes, gId),
                    ModalPins(
                        'Remove from Current Group', Icons.remove, notes, gId),
                    ModalPins('Change color', Icons.ac_unit, notes, gId),
                  ],
                );
              },
            );

            // showModalBottomSheet<void>(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return Container(
            //       height: 110,
            //       color: Colors.white,
            //       child: Center(
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           mainAxisSize: MainAxisSize.min,
            //           children: <Widget>[
            //             ModalPins('Pin', Icons.push_pin_outlined, notes),
            //             ModalPins('Delete', Icons.delete_outline, notes),
            //             ModalPins('Change color', Icons.ac_unit, notes),
            //           ],
            //         ),
            //       ),
            //     );
            //   },
            // );
          },
        ),
        Positioned(
          right: 15,
          top: 22,
          child: Icon(
            notes.isPinned ? Icons.push_pin_rounded : Icons.push_pin_outlined,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class ModalPins extends StatelessWidget {
  String text;
  IconData icons;
  Notes note;
  final String gId;
  ModalPins(this.text, this.icons, this.note, this.gId);
  var _iconColor = Colors.blueAccent[100];

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<NotesProvider>(context);
    var _groupProvider = Provider.of<GroupProvider>(context);
    if (text == 'Delete') {
      _iconColor = Colors.blueAccent[100];
    } else if (text == 'Pin') {
      if (note.isPinned) {
        icons = Icons.push_pin;
      } else {
        icons = Icons.push_pin_outlined;
      }
    }
    return InkWell(
      onTap: () {
        if (text == 'Pin') {
          _provider.pinNote(note.id);
          // print(note.isPinned);
        } else if (text == 'Delete') {
          _provider.deleteById(note.id);
          Navigator.of(context).pop();
        } else if (text == 'Remove from Current Group') {
          if (gId == '1') {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 28.0),
                        child: Text(
                          'This Action will delete the note. Are you Sure?',
                          style: TextStyle(color: Colors.grey, fontSize: 20.0),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _provider.deleteById(note.id);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Yes',
                          style: TextStyle(color: Colors.green, fontSize: 18.0),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'No',
                          style: TextStyle(color: Colors.red, fontSize: 18.0),
                        ),
                      )
                    ],
                  );
                });
          } else {
            _provider.changeGroupDetails(note.id, gId);
            Navigator.of(context).pop();
          }
        } else if (text == 'Add to Another Group') {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 28.0),
                      child: Text(
                        'Current list of groups available.',
                        style: TextStyle(
                            color: Colors.blueAccent[100], fontSize: 20.0),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      height: min(
                          300.0, (_groupProvider.getGroups.length - 1) * 35.0),
                      width: 300,
                      child: ListView.builder(
                          itemCount: _groupProvider.getGroups.length - 1,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                _provider.addToGroup(
                                    note,
                                    _groupProvider
                                        .getGroups[index + 1].groupId);
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Center(
                                  child: Text(
                                    _groupProvider
                                        .getGroups[index + 1].groupName,
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.grey),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onSubmitted: (value) {
                          Provider.of<GroupProvider>(context, listen: false)
                              .addGroup(value);
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Create a group',
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Back',
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    )
                  ],
                );
              });
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Icon(
              icons,
              color: _iconColor,
            ),
          ),
          Container(
            // width: double.infinity - 200,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
            child: Text(
              text,
              style: TextStyle(fontSize: 20.0, color: Colors.black54),
            ),
            // decoration: BoxDecoration(border: Border.all(width: 0)),
          ),
        ],
      ),
    );
  }
}
