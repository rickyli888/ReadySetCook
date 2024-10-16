import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ready_set_cook/shared/constants.dart';
import 'package:ready_set_cook/services/grocery.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Manual extends StatefulWidget {
  @override
  _ManualState createState() => _ManualState();
}

class _ManualState extends State<Manual> {
  GroceryDatabase _groceryDB = null;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();

  String _name = '';
  String _quantity = "";
  String _unit = '';
  int _shelfLife = 15;
  DateTime _startDate = DateTime.now();

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

  Future<void> _onSubmit() async {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      if (_image != null) {
        var ref = FirebaseStorage.instance
            .ref()
            .child('storage_image')
            .child(_filePath);
        await ref.putFile(_image).whenComplete(() => null);
        _imageUrl = await ref.getDownloadURL();
      }

      _groceryDB.addItem(Ingredient(
          name: _name,
          quantity: _quantity,
          unit: _unit,
          startDate: _startDate,
          shelfLife: _shelfLife,
          imageUrl: _imageUrl));
      _image = null;
      _imageUrl = null;
      _controller1.clear();
      _controller2.clear();
      _controller3.clear();
      _controller4.clear();

      _formKey.currentState.save();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_groceryDB == null) {
      _groceryDB = GroceryDatabase(context);
    }

    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 200,
                    width: 200,
                    child: (_image == null)
                        ? Image(
                            image: NetworkImage(
                                "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png"))
                        : Image.file(_image),
                  ),
                  FlatButton(
                    color: Colors.grey[300],
                    child: Text("Add Image"),
                    onPressed: getImage,
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    controller: _controller1,
                    key: ValueKey("ingredient name"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "please enter valid ingredient name";
                      }
                      return null;
                    },
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Enter Ingredient Name'),
                    onChanged: (val) {
                      setState(() => _name = val);
                    },
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    controller: _controller2,
                    key: ValueKey("quantity"),
                    validator: (value) {
                      if (value.isEmpty || int.tryParse(value) == null) {
                        return "please enter valid quantity";
                      }
                      return null;
                    },
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Enter Quantity'),
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      setState(() => _quantity = val);
                    },
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    controller: _controller3,
                    key: ValueKey("unit"),
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Enter Unit (Optional)'),
                    onChanged: (val) {
                      setState(() => _unit = val);
                    },
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    controller: _controller4,
                    key: ValueKey("Shelf Life"),
                    validator: (value) {
                      if (value.isNotEmpty && int.tryParse(value) == null) {
                        return "please enter valid shelf life";
                      }
                      return null;
                    },
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Enter Shelf Life (Optional)'),
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      setState(() => _shelfLife = int.parse(val));
                    },
                  ),
                  SizedBox(height: 15.0),
                  RaisedButton(
                      color: Colors.blue[400],
                      child: Text(
                        'Enter',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: _onSubmit),
                ],
              ),
            )),
      ),
    );
  }
}
