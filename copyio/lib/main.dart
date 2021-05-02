import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:copyio/home.dart';
import 'package:copyio/models/notes.dart';
import 'package:copyio/notes_detail.dart';
import 'package:copyio/providers/notes_provider.dart';
import 'package:copyio/viewall.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notes_card.dart';
import 'settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotesProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CopyIO',
        theme: ThemeData(primaryColor: Colors.blueAccent[100]),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    Home(),
    Text('Search Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Profile Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    var _items = Provider.of<NotesProvider>(context).getNotes;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0.0,
      // ),
      backgroundColor: Colors.white,
      body: _widgetOptions[_currentIndex],
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,

        onItemSelected: (index) {
          // print(index);
          setState(
            () => _currentIndex = index,
          );
        },

        // onTap: (int index) {},
        // type: BottomNavigationBarType.fixed,
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home_filled),
            title: Text('Home'),
            activeColor: Colors.blueAccent[100],
            textAlign: TextAlign.center,
            inactiveColor: Colors.blueAccent[50],
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.local_activity_outlined),
            title: Text('Activity'),
            activeColor: Colors.blueAccent[100],
            textAlign: TextAlign.center,
            inactiveColor: Colors.blueAccent[50],
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.account_circle_outlined),
            title: Text('Profile'),
            activeColor: Colors.blueAccent[100],
            textAlign: TextAlign.center,
            inactiveColor: Colors.blueAccent[50],
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            activeColor: Colors.blueAccent[100],
            textAlign: TextAlign.center,
            inactiveColor: Colors.blueAccent[50],
          ),
        ],
      ),
    );
  }
}
