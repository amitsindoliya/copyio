import 'package:flutter/material.dart';

class NotesDetail extends StatefulWidget {
  final String title;
  final String body;
  NotesDetail(
    this.title,
    this.body,
  );

  @override
  _NotesDetailState createState() => _NotesDetailState();
}

class _NotesDetailState extends State<NotesDetail> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _titlecontroller;
    TextEditingController _bodyController;
    _titlecontroller = new TextEditingController();
    _bodyController = new TextEditingController();
    _titlecontroller.text = widget.title;
    _bodyController.text = widget.body;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(Icons.check),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _titlecontroller,
                          // title,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                              // border: InputBorder.none,
                              hintText: 'Title',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.blueGrey,
                              )),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            // autofocus: true,
                            controller: _bodyController,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              // hintText: 'body',
                            ),
                          ),
                        )
                      ],
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
