import 'package:copyio/models/notes.dart';
import 'package:copyio/notes_card.dart';
import 'package:copyio/notes_detail.dart';
import 'package:copyio/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewAllNotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Notes> _allNotes = Provider.of<NotesProvider>(context).getNotes;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.0),
              topRight: Radius.circular(32.0),
            ),
          ),
          // height: MediaQuery.of(context).size.height * 0.38,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                // margin: EdgeInsets.fromLTRB(40, 3, 40, 3),
                margin: EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 8,
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Notes',
                    hintStyle: TextStyle(
                      color: Colors.black.withAlpha(120),
                    ),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search_sharp,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 10.0,
              // ),
              Expanded(
                // height: MediaQuery.of(context).size.height * 0.8,
                child: GridView.builder(
                  // scrollDirection: Axis.horizontal,
                  itemCount: _allNotes.length,
                  itemBuilder: (context, index) {
                    return NotesCard(
                      _allNotes[index],
                      MediaQuery.of(context).size.height * 0.4,
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height * 0.9),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent[100],
        onPressed: () {
          return Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NotesDetail(
                    null,
                    null,
                    null,
                    null,
                  )));
        },
      ),
    );
  }
}
