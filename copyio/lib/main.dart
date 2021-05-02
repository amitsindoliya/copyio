import 'package:copyio/notes_detail.dart';
import 'package:copyio/providers/notes_provider.dart';
import 'package:copyio/viewall.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dummy_data.dart';
import 'notes_card.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotesProvider()),
      ],
      child: MaterialApp(
        title: 'CopyIO',
        theme: ThemeData(primaryColor: Colors.blueAccent[100]),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _items = Provider.of<NotesProvider>(context).getNotes;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0.0,
      // ),
      backgroundColor: Colors.white,
      body: Column(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'All Notes',
                style: TextStyle(
                  color: Colors.blueAccent[100],
                  fontSize: 20.0,
                  // decoration: TextDecoration.underline,
                  // decorationThickness: 4,
                ),
              ),
              Text(
                'Group1',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0,
                ),
              ),
              Text(
                'Group2',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.38,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _items.length > 10 ? 11 : _items.length,
              itemBuilder: (context, index) {
                if (index < 10) {
                  return NotesCard(
                    _items[index],
                    MediaQuery.of(context).size.height * 0.38,
                  );
                } else {
                  return ViewAll();
                }
              },
            ),
          ),
          NewNote(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (int index) {},
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity_outlined),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class NewNote extends StatelessWidget {
  const NewNote({
    Key key,
  }) : super(key: key);

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
                  builder: (context) => NotesDetail(null, null, null, null)));
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
