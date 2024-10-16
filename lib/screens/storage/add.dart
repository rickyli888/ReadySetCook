import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/storage/manual.dart';
import 'package:ready_set_cook/screens/storage/common_add.dart';

class Add extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _tabPages = <Widget>[
      Center(child: CommonAdd()),
      Center(child: Manual()),
    ];
    final _tabs = <Tab>[
      const Tab(icon: Icon(Icons.fastfood), text: 'Common Ingredients'),
      const Tab(icon: Icon(Icons.accessibility), text: 'Enter Manually')
    ];
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          title: const Text('Add Items'),
          // If `TabController controller` is not provided, then a
          // DefaultTabController ancestor must be provided instead.
          // Another way is to use a self-defined controller, c.f. "Bottom tab
          // bar" example.
          bottom: TabBar(
            tabs: _tabs,
          ),
        ),
        body: TabBarView(
          children: _tabPages,
        ),
      ),
    );
  }
}
