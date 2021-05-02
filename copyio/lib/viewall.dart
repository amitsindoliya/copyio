import 'package:flutter/material.dart';

import 'view_all_notes_screen.dart';

class ViewAll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        // color: Colors.teal[200],
        width: MediaQuery.of(context).size.width * 0.4,
        margin: EdgeInsets.all(10.0),
        // padding: EdgeInsets.all(20),
        child: Center(
          child: Text(
            'View all >>',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.blueAccent[100],
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ViewAllNotesScreen(),
          ),
        );
      },
    );
  }
}
