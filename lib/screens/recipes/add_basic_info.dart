import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ready_set_cook/shared/constants.dart';

class AddBasic extends StatefulWidget {
  final Function toggleView;
  AddBasic({this.toggleView});

  @override
  _AddBasic createState() => _AddBasic();
}

class _AddBasic extends State<AddBasic> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  int rating = null;
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 15.0),
                  TextFormField(
                    controller: _controller1,
                    key: ValueKey("name"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please Enter Name for Recipe";
                      }
                      return null;
                    },
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Enter Recipe Name'),
                    onChanged: (val) {
                      setState(() => name = val);
                    },
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    controller: _controller2,
                    key: ValueKey("rating"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please Enter Valid Rating";
                      }
                      return null;
                    },
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Enter Rating'),
                    onChanged: (val) {
                      setState(() => rating = int.parse(val));
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
