import 'package:copyio/models/groups.dart';
import 'package:copyio/models/notes.dart';
import 'package:copyio/notes_card.dart';
import 'package:copyio/notes_detail.dart';
import 'package:copyio/providers/groups_provider.dart';
import 'package:copyio/providers/notes_provider.dart';
import 'package:copyio/viewall.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  // const Home({
  //   Key key,
  //   @required List<Notes> items,
  // }) : _items = items, super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Notes> _items;

  List<Group> _groups;

  String _groupIndex = '1';
  int _gInd = 0;

  @override
  Widget build(BuildContext context) {
    var _itemProvider = Provider.of<NotesProvider>(context);
    _items = _itemProvider.getNotes;
    _groups = Provider.of<GroupProvider>(context).getGroups;
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: MediaQuery.of(context).padding.top * 2.2,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.supervised_user_circle_sharp,
                size: 70,
                color: Colors.blueAccent[100],
              ),
              Text(
                'Welcome Back',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Look at all your notes!',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15.0,
                ),
              )
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.05,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _groups.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(
                      () {
                        _groupIndex = _groups[index].groupId;
                        _gInd = index;
                        // print(_gInd.toString() + '///s');
                      },
                    );

                    // print(_groupIndex);
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0.0),
                    child: _gInd == index
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: Colors.blueAccent[100],
                                    width: 2,
                                    style: BorderStyle.solid),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  _groups[index].groupName,
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.blueAccent[100]),
                                ),
                              ],
                            ),
                          )
                        : Text(_groups[index].groupName,
                            style:
                                TextStyle(fontSize: 22.0, color: Colors.grey)),
                  ),
                );
              }),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.38,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _itemProvider.getGroup(_groupIndex).length > 5
                ? 6
                : _itemProvider.getGroup(_groupIndex).length,
            itemBuilder: (context, index) {
              if (index < 5) {
                // print(_groupIndex);
                return NotesCard(
                  _itemProvider.getGroup(_groupIndex)[index],
                  MediaQuery.of(context).size.height * 0.38,
                  false,
                );
              } else {
                return ViewAll(_groupIndex);
              }
            },
          ),
        ),
        NewNote(_groupIndex),
      ],
    );
  }
}

class NewNote extends StatelessWidget {
  final String gID;
  NewNote(this.gID);
  // gIDList = gID == '1' ? ['1'] :[];
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.blueAccent[100],
              ),
              elevation: MaterialStateProperty.all<double>(2.0),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              // RoundedRectangleBorder(borderRasdius: BorderRadius.circular(30)),
            ),
            onPressed: () {
              return Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NotesDetail(null, null, null, null,
                      null, gID == '1' ? ['1'] : ['1', gID], null)));
            },
            child: Text(
              'Add a new note',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
