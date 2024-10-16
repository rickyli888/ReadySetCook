import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ready_set_cook/screens/profile/edit_profile.dart';
import 'package:ready_set_cook/services/auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller1 = TextEditingController();
  final AuthService _auth = AuthService();

  String _name = null;

  File _image = null;
  String _imageUrl = null;
  String _filePath = null;
  final _picker = ImagePicker();

  void getImage() async {
    final pickedFile =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    _filePath = pickedFile.path;
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text("Update"),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditProfile()));
          }),
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30.0),
                  Center(
                    child: Container(
                      height: 200,
                      width: 200,
                      child: (_image == null)
                          ? Image(
                              image: NetworkImage(_auth
                                          .getCurrentUserPhotoURL() !=
                                      null
                                  ? _auth.getCurrentUserPhotoURL()
                                  : "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png"))
                          : Image.file(_image),
                    ),
                  ),
                  SizedBox(height: 45.0),
                  Text(
                      _auth.getCurrentUserdiaplayName() != null
                          ? "Name: " + _auth.getCurrentUserdiaplayName()
                          : "No username",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black,
                      )),
                  SizedBox(height: 45.0),
                  Text(
                      _auth.getCurrentUserEmail() != null
                          ? "Email: " + _auth.getCurrentUserEmail()
                          : "No email",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black,
                      )),
                ],
              ),
            )),
      ),
    );
  }
}
