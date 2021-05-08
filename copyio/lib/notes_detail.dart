import 'package:copyio/dummy_data.dart';
import 'package:copyio/models/notes.dart';
import 'package:copyio/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotesDetail extends StatefulWidget {
  final String id;
  final String title;
  final String body;
  final DateTime time;
  NotesDetail(this.id, this.title, this.body, this.time);

  @override
  _NotesDetailState createState() => _NotesDetailState();
}

class _NotesDetailState extends State<NotesDetail> {
  final _fkey = GlobalKey<FormState>();
  var _sampleNote = Notes(
    id: '',
    title: '',
    body: '',
  );
  void _saveForm() {
    _fkey.currentState.save();
    if (_sampleNote.id == '') {
      _sampleNote = Notes(
        id: DateTime.now().toString(),
        title: _sampleNote.title,
        body: _sampleNote.body,
        generatedTime: DateTime.now(),
      );
      Provider.of<NotesProvider>(context, listen: false).setNotes(_sampleNote);
    } else {
      _sampleNote = Notes(
        id: _sampleNote.id,
        title: _sampleNote.title,
        body: _sampleNote.body,
        generatedTime: DateTime.now(),
      );
      Provider.of<NotesProvider>(context, listen: false)
          .changeById(_sampleNote);
    }
    Navigator.of(context).pop();
  }

  bool _editFlag = true;

  @override
  void didChangeDependencies() {
    if (_editFlag) {
      print(widget.id);
      if (widget.id != null) {
        _sampleNote = Notes(
            id: widget.id,
            title: widget.title,
            body: widget.body,
            generatedTime: widget.time);
      }
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
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
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
                              color: Theme.of(context).primaryColor,
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
