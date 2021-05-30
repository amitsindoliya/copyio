import 'package:copyio/models/notes.dart';
import 'package:copyio/providers/groups_provider.dart';
import 'package:copyio/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/groups.dart';
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
                return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    title: Text(
                      'Note Settings',
                      style: TextStyle(fontSize: 24.0),
                    ),
                    content: Builder(
                      builder: (context) {
                        return Container(
                          height: 200,
                          // width: 400,
                          child: Column(
                            children: [
                              ModalPins(
                                  'Pin', Icons.push_pin_outlined, notes, gId),
                              ModalPins(
                                  'Delete', Icons.delete_outline, notes, gId),
                              ModalPins('Add to Another Group', Icons.add,
                                  notes, gId),
                              ModalPins('Remove from Group', Icons.remove,
                                  notes, gId),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 150,
                                child: ElevatedButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.grey),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.pressed))
                                          return Color(0xFFEDF1F7);
                                        return Color(0xFFEDF1F7);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ));
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

class ModalPins extends StatefulWidget {
  String text;
  IconData icons;
  Notes note;
  final String gId;
  ModalPins(this.text, this.icons, this.note, this.gId);

  @override
  _ModalPinsState createState() => _ModalPinsState();
}

class _ModalPinsState extends State<ModalPins> {
  var _iconColor = Colors.blueAccent[100];

  // var newGroupId;
  // String newVal;
  var _groupController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<NotesProvider>(context);
    var _groupProvider = Provider.of<GroupProvider>(context);
    if (widget.text == 'Delete') {
      _iconColor = Colors.blueAccent[100];
    } else if (widget.text == 'Pin') {
      if (widget.note.isPinned) {
        widget.icons = Icons.push_pin;
      } else {
        widget.icons = Icons.push_pin_outlined;
      }
    }
    return InkWell(
      onTap: () {
        if (widget.text == 'Pin') {
          _provider.pinNote(widget.note.id);
          // print(note.isPinned);
        } else if (widget.text == 'Delete') {
          _provider.deleteById(widget.note.id);
          Navigator.of(context).pop();
        } else if (widget.text == 'Remove from Current Group') {
          if (widget.gId == '1') {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    title: Text(
                      'Delete note',
                      style: TextStyle(fontSize: 24.0),
                    ),
                    content: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Text(
                        'This action will remove the note. Are you Sure? You won\'t be able to access the note anymore',
                        style: TextStyle(color: Colors.grey, fontSize: 15.0),
                      ),
                    ),
                    actions: [
                      Container(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            'Cancel',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.grey),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed))
                                  return Color(0xFFEDF1F7);
                                return Color(0xFFEDF1F7);
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            _provider.deleteById(widget.note.id);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Confirm',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed))
                                  return Color(0xFF0066FF);
                                return Color(0xFF0066FF);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                });
          } else {
            _provider.changeGroupDetails(widget.note.id, widget.gId);
            Navigator.of(context).pop();
          }
        } else if (widget.text == 'Add to Another Group') {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return GroupAlert(
                    groupProvider: _groupProvider,
                    provider: _provider,
                    widget: widget);
              });
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Icon(
              widget.icons,
              color: _iconColor,
            ),
          ),
          Container(
            // width: double.infinity - 200,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
            child: Text(
              widget.text,
              style: TextStyle(fontSize: 20.0, color: Colors.black54),
            ),
            // decoration: BoxDecoration(border: Border.all(width: 0)),
          ),
        ],
      ),
    );
  }
}

class GroupAlert extends StatefulWidget {
  GroupAlert({
    Key key,
    // @required this.newVal,
    @required GroupProvider groupProvider,
    // @required this.newGroupId,
    // @required TextEditingController groupController,
    @required NotesProvider provider,
    @required this.widget,
  })  : _groupProvider = groupProvider,
        _provider = provider,
        super(key: key);

  final GroupProvider _groupProvider;
  // final newGroupId;
  // final TextEditingController _groupController;
  final NotesProvider _provider;
  final ModalPins widget;

  @override
  _GroupAlertState createState() => _GroupAlertState();
}

class _GroupAlertState extends State<GroupAlert> {
  var newGroupId;
  String newVal;
  var _groupController = TextEditingController();
  var _isloading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      title: Text(
        'Available groups',
        style: TextStyle(fontSize: 24.0),
      ),
      content: Builder(builder: (context) {
        return Container(
          height: 300,
          child: Column(
            children: [
              Text(
                "Select one of group from dropdown or create a new group",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  // padding: const EdgeInsets.all(0.0),
                  child: DropdownButton<String>(
                    value: newVal,
                    //elevation: 5,
                    style: TextStyle(color: Colors.black),

                    items: widget._groupProvider.getGroups
                        .map<DropdownMenuItem<String>>((Group value) {
                      var itList = DropdownMenuItem<String>(
                        value: value.groupId,
                        child: Text(value.groupName),
                      );

                      return itList;
                    }).toList(),
                    hint: Text(
                      "Select a group",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        newGroupId = value;
                        newVal = value;
                      });
                      print(newGroupId);
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    child: TextField(
                      controller: _groupController,
                      // onSubmitted: (value) {},
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Create a group',
                      ),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () async {
                        setState(() {
                          _isloading = true;
                        });

                        var value = await Provider.of<GroupProvider>(context,
                                listen: false)
                            .addGroup(_groupController.text);
                        newGroupId = value;
                        setState(() {
                          _isloading = false;
                        });
                      })
                ],
              ),
              _isloading
                  ? CircularProgressIndicator()
                  : Container(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          widget._provider
                              .addToGroup(widget.widget.note, newGroupId);

                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Confirm',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed))
                                return Color(0xFF0066FF);
                              return Color(0xFF0066FF);
                            },
                          ),
                        ),
                      ),
                    ),
              Container(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 18.0, color: Colors.grey),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Color(0xFFEDF1F7);
                        return Color(0xFFEDF1F7);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
