import 'package:copyio/models/groups.dart';
import 'package:copyio/models/notes.dart';
import 'package:copyio/notes_card.dart';
import 'package:copyio/notes_detail.dart';
import 'package:copyio/providers/groups_provider.dart';
import 'package:copyio/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class ViewAllNotesScreen extends StatelessWidget {
  final gID;
  ViewAllNotesScreen(this.gID);

  @override
  Widget build(BuildContext context) {
    var _nodeProvider = Provider.of<NotesProvider>(context);
    List<Notes> _allNotes = _nodeProvider.getNotes;
    List<Notes> _currentGroup = _nodeProvider.getGroup(gID);
    List<Group> _groups = Provider.of<GroupProvider>(context).getGroups;
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
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _groups
                          .firstWhere((element) => element.groupId == gID)
                          .groupName,
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                        // color: Colors.blueAccent[100],
                      ),
                    ),
                    Container(
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
                          Icons.search_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 10.0,
              // ),
              Expanded(
                // height: MediaQuery.of(context).size.height * 0.8,
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  itemCount: _currentGroup.length,
                  itemBuilder: (BuildContext context, int index) {
                    // print('iiii' +
                    //     (_allNotes[index].body.length * 0.1).toString());
                    return NotesCard(
                      _currentGroup[index],
                      MediaQuery.of(context).size.height * 0.25,
                      true,
                    );
                  },
                  staggeredTileBuilder: (int index) => new StaggeredTile.count(
                      index % 5 == 0 ? 4 : 2,
                      index % 5 == 0
                          ? min(2.0, _currentGroup[index].body.length * 0.04) >
                                  1
                              ? min(
                                  2.0, _currentGroup[index].body.length * 0.04)
                              : 1.2
                          : min(2.0, _currentGroup[index].body.length * 0.04) >
                                  1.5
                              ? min(
                                  3.0, _currentGroup[index].body.length * 0.04)
                              : 1.5),
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 2.0,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        backgroundColor: Colors.blueAccent[100],
        label: Text('Add'),
        onPressed: () {
          return Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NotesDetail(null, null, null, null, null,
                  gID == '1' ? ['1'] : ['1', gID], null)));
        },
      ),
    );
  }
}
