import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ready_set_cook/shared/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ready_set_cook/services/auth.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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

  Future<void> _onSubmit() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30.0),
                  Container(
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
                  SizedBox(height: 30.0),
                  FlatButton(
                    color: Colors.grey[300],
                    child: Text("Add Image (Optional)"),
                    onPressed: getImage,
                  ),
                  SizedBox(height: 30.0),
                  TextFormField(
                    controller: _controller1,
                    key: ValueKey("username"),
                    decoration: textInputDecoration.copyWith(
                        hintText: 'New Username (Optional)'),
                    onChanged: (val) {
                      setState(() => _name = val);
                    },
                  ),
                  SizedBox(height: 30.0),
                  RaisedButton(
                      color: Colors.blue[400],
                      child: Text(
                        'Enter',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        final isValid = _formKey.currentState.validate();
                        if (isValid) {
                          if (_image != null) {
                            var ref = FirebaseStorage.instance
                                .ref()
                                .child('profile_image')
                                .child(_filePath);
                            await ref.putFile(_image).whenComplete(() => null);
                            _imageUrl = await ref.getDownloadURL();
                          }
                          _auth.updateUserProfile(
                              _name != null
                                  ? _name
                                  : _auth.getCurrentUserdiaplayName(),
                              _imageUrl != null
                                  ? _imageUrl
                                  : _auth.getCurrentUserPhotoURL());
                          _image = null;
                          _imageUrl = null;
                          _controller1.clear();
                          //_formKey.currentState.save();
                        }

                        setState(() {});
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            )),
      ),
    );
  }
}
