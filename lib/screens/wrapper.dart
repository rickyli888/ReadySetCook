import 'package:ready_set_cook/models/user.dart';
import 'package:ready_set_cook/screens/authenticate/authenticate.dart';
import 'package:ready_set_cook/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as p;

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = p.Provider.of<User>(context);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }

    //return Home();
  }
}
