import 'package:copyio/dummy_data.dart';
import 'package:copyio/models/notes.dart';
import 'package:copyio/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class NotesDetail extends StatefulWidget {
  final String id;
  final String title;
  final String body;
  final DateTime time;
  final Color color;
  final List<String> group;
  final bool pinStatus;
  NotesDetail(
    this.id,
    this.title,
    this.body,
    this.time,
    this.color,
    this.group,
    this.pinStatus,
  );

  @override
  _NotesDetailState createState() => _NotesDetailState();
}

class _NotesDetailState extends State<NotesDetail> {
  final _fkey = GlobalKey<FormState>();
  var _sampleNote = Notes(
    id: '',
    title: '',
    body: '',
    group: ['1'],
  );

  void _saveForm() {
    _fkey.currentState.save();
    if (_sampleNote.id == '') {
      _sampleNote = Notes(
        id: DateTime.now().toString(),
        title: _sampleNote.title,
        body: _sampleNote.body,
        generatedTime: DateTime.now(),
        group: _sampleNote.group,
        color: _sampleNote.color,
      );
      Provider.of<NotesProvider>(context, listen: false).setNotes(_sampleNote);
    } else {
      _sampleNote = Notes(
        id: _sampleNote.id,
        title: _sampleNote.title,
        body: _sampleNote.body,
        generatedTime: DateTime.now(),
        color: _sampleNote.color,
        group: _sampleNote.group,
        isPinned: _sampleNote.isPinned,
      );
      Provider.of<NotesProvider>(context, listen: false)
          .changeById(_sampleNote);
    }
    Navigator.of(context).pop();
  }

  bool _editFlag = true;
  Color dropdownValue;
  @override
  void didChangeDependencies() {
    if (_editFlag) {
      // print(widget.pinStatus);

      if (widget.id != null) {
        _sampleNote = Notes(
          id: widget.id,
          title: widget.title,
          body: widget.body,
          generatedTime: widget.time,
          color: widget.color,
          group: widget.group,
          isPinned: widget.pinStatus,
        );
      } else {
        _sampleNote = Notes(
          id: _sampleNote.id,
          title: _sampleNote.title,
          body: _sampleNote.body,
          group: widget.group,
        );
      }
      dropdownValue = _sampleNote.color;
    }

    _editFlag = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // TextEditingController _titlecontroller;
    // TextEditingController _bodyController;
    // _titlecontroller = new TextEditingController();
    // _bodyController = new TextEditingController();
    // _titlecontroller.text = widget.title;
    // _bodyController.text = widget.body;
    Widget _colorPicker() {
      return DropdownButton<Color>(
        value: dropdownValue,
        // icon: Container(
        //   margin: EdgeInsets.all(6.5),
        //   // color: Colors.black26,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.all(
        //       Radius.circular(14.0),
        //     ),
        //     color: Colors.black12,
        //   ),
        //   child: IconButton(
        //     icon: Icon(
        //       Icons.color_lens_rounded,
        //       color: Colors.white,
        //     ),
        // onPressed: () {},
        //   ),
        // ),
        // iconSize: 24,
        elevation: 12,
        underline: Container(),
        onChanged: (Color newValue) {
          setState(() {
            dropdownValue = newValue;
            _sampleNote = Notes(
              id: _sampleNote.id,
              title: _sampleNote.title,
              body: _sampleNote.body,
              color: newValue,
              group: _sampleNote.group,
              isPinned: _sampleNote.isPinned,
            );
          });
        },
        items: <Color>[
          Colors.blueAccent[100],
          Colors.redAccent[100],
          Colors.greenAccent[100],
          Colors.deepOrangeAccent[100],
          Colors.red[100],
          Colors.blue[100],
          Colors.green[100],
          Colors.orange[100],
          Colors.amberAccent[100],
          Colors.cyan[100],
          Colors.brown[100],
          Colors.purple[100]
        ].map<DropdownMenuItem<Color>>((Color value) {
          return DropdownMenuItem<Color>(
            value: value,
            child: Container(
              margin: EdgeInsets.only(top: 6.5),
              width: 37,
              height: 37,
              // color: value,
              child: dropdownValue == value
                  ? Center(
                      child: Icon(
                      Icons.color_lens_outlined,
                      color: Colors.black54,
                    ))
                  : Text(''),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  border: Border.all(color: Colors.black54, width: 1.5),
                  color: value),
            ),
          );
        }).toList(),
      );
    }

    // Key k1 = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: Container(
          margin: EdgeInsets.all(6.0),
          // color: Colors.black26,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(14.0),
            ),
            color: Colors.black12,
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        actions: [
          _colorPicker(),
          InkWell(
            onTap: _saveForm,
            child: Container(
              margin: EdgeInsets.all(6.5),
              // color: Colors.black26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(14.0),
                ),
                color: Colors.black12,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                ),
                // onPressed: () {},
              ),
            ),
          ),
        ],
        backgroundColor: _sampleNote.color,
      ),
      backgroundColor: _sampleNote.color,
      body: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        ),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    // height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0),
                      ),
                    ),
                    child: Form(
                      key: _fkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            // controller: _titlecontroller,
                            // title,
                            // key: k1,
                            maxLines: null,
                            keyboardType: TextInputType.text,
                            initialValue: _sampleNote.title,
                            style: TextStyle(
                              color: _sampleNote.color,
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              // border: InputBorder.none,
                              hintText: 'Title',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.blueGrey,
                              ),
                            ),
                            onSaved: (text) {
                              _sampleNote = Notes(
                                id: _sampleNote.id,
                                title: text,
                                body: _sampleNote.body,
                                color: _sampleNote.color,
                                group: _sampleNote.group,
                                isPinned: _sampleNote.isPinned,
                              );
                            },
                          ),
                          _sampleNote.generatedTime != null
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      _sampleNote.generatedTime
                                          .toString()
                                          .split('.')[0],
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                )
                              : Text(''),
                          // SizedBox(
                          //   height: 5.0,
                          // ),
                          Expanded(
                            child: TextFormField(
                              initialValue: _sampleNote.body,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              // autofocus: true,
                              // controller: _bodyController,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                // hintText: 'body',
                              ),
                              onSaved: (text) {
                                _sampleNote = Notes(
                                  id: _sampleNote.id,
                                  title: _sampleNote.title,
                                  body: text,
                                  color: _sampleNote.color,
                                  group: _sampleNote.group,
                                  isPinned: _sampleNote.isPinned,
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
