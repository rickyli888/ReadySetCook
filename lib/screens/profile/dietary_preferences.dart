//import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ready_set_cook/services/auth.dart';
import 'package:ready_set_cook/shared/constants.dart';
import 'package:ready_set_cook/screens/profile/edit_password.dart';
import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/profile/profile.dart';
import 'package:ready_set_cook/screens/home/home.dart';
import 'package:ready_set_cook/services/allergy_service.dart';
import 'package:ready_set_cook/models/allergies.dart';
import 'package:ready_set_cook/screens/profile/add_allergy.dart';

class Allergy extends StatefulWidget {
  final Function toggleView;
  Allergy({this.toggleView});

  @override
  _AllergyState createState() => _AllergyState();
}

class _AllergyState extends State<Allergy> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  AllergyDatabase _allergyDB = null;
  final fireInstance =
      FirebaseFirestore.instance.collection("dietary preferences");

  @override
  Widget build(BuildContext context) {
    if (_allergyDB == null) {
      _allergyDB = AllergyDatabase(context);
    }

    return Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Dietary Preference'),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Add_allergy()),
            );
          },
          icon: Icon(Icons.add),
          label: Text("Add"),
        ),
        body: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0))),
            child: StreamBuilder(
                stream: _allergyDB.getAllergySnap(),
                builder: (ctx, allergySnapshot) {
                  if (allergySnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final allergySnap = allergySnapshot.data.documents;
                  return ListView.builder(
                      itemCount: allergySnap.length,
                      itemBuilder: (ctx, index) {
                        final String allergy_id = allergySnap[index].id;
                        final String allergy_name =
                            allergySnap[index]["allergy"];

                        return Dismissible(
                          onDismissed: (DismissDirection direction) {
                            setState(() {
                              _allergyDB.deleteAllergy(allergy_id);
                            });
                            
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      title: Text(allergy_name + " deleted"),
                                    ));
                          },
                          background: Container(color: Colors.red),
                          child: ListTile(title: Text('$allergy_name')),
                          key: Key(allergy_id),
                        );
                      });
                })));
  }
}
