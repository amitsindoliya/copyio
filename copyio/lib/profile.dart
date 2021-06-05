import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('My Profile',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
          Icon(
            Icons.account_circle,
            size: 80.0,
          ),
          Container(
            height: 80,
            width: double.infinity,
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              color: Color(0xFFF0F2F5),
            ),
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: Text('Personal Info'),
          )
        ],
      ),
    );
  }
}
