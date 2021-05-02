import 'package:flutter/material.dart';
import 'notes_detail.dart';

class NotesCard extends StatelessWidget {
  final String id;
  final String title;
  final String body;
  final double height;

  NotesCard(this.id, this.title, this.body, this.height);

  notesPageNavigator(BuildContext context, title, body) {
    return Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => NotesDetail(id, title, body)));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        // color: Colors.teal[200],
        width: MediaQuery.of(context).size.width * 0.4,
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            Container(
              height: height * 0.7,
              child: Text(
                body,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  color: Colors.white54,
                ),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.blueAccent[100],
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      onTap: () {
        notesPageNavigator(context, title, body);
      },
    );
  }
}
