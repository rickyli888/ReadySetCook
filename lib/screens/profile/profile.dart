import 'package:firebase_auth/firebase_auth.dart';
import 'package:ready_set_cook/screens/profile/report_error.dart';
import 'package:ready_set_cook/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/profile/edit_password.dart';
import 'package:ready_set_cook/screens/profile/forgot_password.dart';
import 'package:ready_set_cook/services/auth.dart' as fire;
import 'package:ready_set_cook/models/user.dart';
import 'package:ready_set_cook/screens/profile/dietary_preferences.dart';
import 'package:ready_set_cook/screens/profile/profile_page.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();

  String _userName = "My Name";
  bool _notification = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          backgroundColor: Colors.blue[50],
          body: ListView(children: <Widget>[
            ListTile(
              trailing: CircleAvatar(
                backgroundImage: NetworkImage(_auth.getCurrentUserPhotoURL() !=
                        null
                    ? _auth.getCurrentUserPhotoURL()
                    : "https://www.streamscheme.com/wp-content/uploads/2020/04/poggers.png"),
              ),
              title: Text('Username'),
              subtitle: Text(_auth.getCurrentUserdiaplayName() != null
                  ? _auth.getCurrentUserdiaplayName()
                  : "loading or no Username"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            ListTile(
              title: Text('Email'),
              subtitle: Text(_auth.getCurrentUserEmail()),
            ),
            ListTile(
              title: Text('Password Reset'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePassword()),
                );
              },
            ),
            ListTile(
              title: Text('Dietary Preferences'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Allergy()),
                );
              },
            ),
            ListTile(
              title: Text('Report Error'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportError()),
                );
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.person, color: Colors.red),
              label: Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ])),
    );
  }
}
