import 'package:ready_set_cook/screens/wrapper.dart';
import 'package:ready_set_cook/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as p;
import 'package:ready_set_cook/models/user.dart';
import 'package:firebase_core/firebase_core.dart';

// void main() => runApp(MyApp());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return p.StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
