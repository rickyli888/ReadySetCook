import 'package:ready_set_cook/screens/recipes/recipe.dart';
import 'package:ready_set_cook/screens/recommend/recommend.dart';
import 'package:ready_set_cook/screens/storage/storage.dart';
import 'package:ready_set_cook/screens/profile/profile.dart';
import 'package:ready_set_cook/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:ready_set_cook/shared/constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  int _selectedIndex = 1;

  static List<Widget> _widgetOptions = <Widget>[
    Recommend(),
    Recipe(),
    Storage(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('ReadySetCook!'),
        backgroundColor: Colors.blue[120],
        elevation: 0.0,
        leading:
            Padding(padding: const EdgeInsets.all(8.0), child: SmallLogo()),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_rounded),
            label: 'Recommended',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox),
            label: 'Storage',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[400],
        onTap: _onItemTapped,
      ),
    ));
  }
}
