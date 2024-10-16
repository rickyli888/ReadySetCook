import 'package:flutter/material.dart';
import 'package:ready_set_cook/shared/constants.dart';
import 'package:ready_set_cook/services/grocery.dart';
import 'package:ready_set_cook/models/ingredient.dart';

class Edit extends StatefulWidget {
  final Ingredient _ingredient;
  Edit(this._ingredient);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  GroceryDatabase _groceryDB = null;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _name;
  String _quantity;
  String _unit;

  @override
  void initState() {
    super.initState();
    _controller1.text = widget._ingredient.name;
    _controller2.text = widget._ingredient.quantity.toString();
    _controller3.text = widget._ingredient.unit;
    // initial value to hold
    _name = widget._ingredient.name;
    _quantity = widget._ingredient.quantity;
    _unit = widget._ingredient.unit;
  }

  void _onSubmit() {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      widget._ingredient.name = _name;
      widget._ingredient.quantity = _quantity;
      widget._ingredient.unit = _unit;
      _groceryDB.updateItem(widget._ingredient);
      _formKey.currentState.save();
    }
    setState(() {});
  }

  Widget build(BuildContext context) {
    if (_groceryDB == null) {
      _groceryDB = GroceryDatabase(context);
    }

    return Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(title: Text('Edit ' + widget._ingredient.name)),
        key: _scaffoldKey,
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                        height: 240,
                        width: 250,
                        child: (widget._ingredient.imageUrl == null)
                            ? Image(
                                image: NetworkImage(
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png"))
                            : Image(
                                image:
                                    NetworkImage(widget._ingredient.imageUrl))),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _controller1,
                      key: ValueKey("ingredient name"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter valid ingredient name";
                        }
                        return null;
                      },
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Update Name'),
                      onChanged: (val) {
                        setState(() => _name = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _controller2,
                      key: ValueKey("quantity"),
                      validator: (value) {
                        if (value.isEmpty || int.tryParse(value) == null) {
                          return "Please enter a valid quantity";
                        }
                        return null;
                      },
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Update Quantity'),
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        setState(() => _quantity = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _controller3,
                      key: ValueKey("unit"),
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Update Unit'),
                      onChanged: (val) {
                        setState(() => _unit = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        color: Colors.blue[400],
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text("Successfully updated")));
                          }
                          _onSubmit();
                        }),
                  ],
                ),
              )),
        ));
  }
}
