import 'package:copyio/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Settings',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                elevation: 1.0,
                child: ListTile(
                  // leading: Icon(Icons.arrow_right_alt_rounded),
                  title: Text('Dark Mode'),
                  subtitle: Text('Change App\'s theme'),
                  trailing: Switch(
                    value: false,
                    onChanged: (newValue) {},
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  // leading: Icon(Icons.album),
                  title: Text('Change theme'),
                  subtitle: Text('Choose a theme from predefined colors'),
                ),
              ),
              Card(
                child: ListTile(
                  // leading: Icon(Icons.album),
                  title: Text('Add/Remove Groups'),
                  subtitle: Text('Organize your notes'),
                ),
              ),
              Card(
                child: ListTile(
                  // leading: Icon(Icons.album),
                  title: Text('Donate Us'),
                  subtitle: Text('Please help us keep our servers up!'),
                ),
              ),
              Card(
                child: GestureDetector(
                  onTap: () {
                    Provider.of<Auth>(context, listen: false).logout();
                  },
                  child: ListTile(
                    // leading: Icon(Icons.album),
                    title: Text('Sign Out'),
                    subtitle: Text('Please don\'t'),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  // leading: Icon(Icons.album),
                  title: Text('Rate Us'),
                  subtitle: Text('Help us improve.'),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
