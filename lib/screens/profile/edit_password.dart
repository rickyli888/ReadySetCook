import 'package:ready_set_cook/services/auth.dart';
import 'package:ready_set_cook/shared/constants.dart';
import 'package:ready_set_cook/screens/profile/edit_password.dart';
import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/profile/profile.dart';
import 'package:ready_set_cook/screens/home/home.dart';

class ChangePassword extends StatefulWidget {
  final Function toggleView;
  ChangePassword({this.toggleView});

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = 'myemail@gmail.com'; //need to get email from user info
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        },
        child: Icon(Icons.arrow_back),
      ),
      */
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 40.0),
                  Text(
                    "An password reset Email will be sent to your email account!",
                    style: new TextStyle(
                      fontSize: 30.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  /*
                  SizedBox(height: 40.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val.isEmpty ? 'Enter your email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  */
                  SizedBox(height: 40.0),
                  RaisedButton(
                      color: Colors.blue[400],
                      child: Text(
                        'Password Reset',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        await _auth.resetPassword(_auth.getCurrentUserEmail());
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: Text('Email sent to ' +
                                      _auth.getCurrentUserEmail()),
                                  content: Text(
                                      'Please follow instructions on your email'),
                                ));
                      }),

                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                  SizedBox(height: 12.0),
                  //BigLogo()
                ],
              ),
            )),
      ),
    );
  }
}
