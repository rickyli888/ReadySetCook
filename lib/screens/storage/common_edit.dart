import 'package:flutter/material.dart';
import 'package:ready_set_cook/models/nutrition.dart';
import 'package:ready_set_cook/shared/constants.dart';
import 'package:ready_set_cook/services/grocery.dart';
import 'package:ready_set_cook/models/ingredient.dart';

class CommonEdit extends StatefulWidget {
  final Ingredient _ingredient;
  CommonEdit(this._ingredient);

  @override
  _CommonEditState createState() => _CommonEditState();
}

class _CommonEditState extends State<CommonEdit> {
  GroceryDatabase _groceryDB = null;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();

  String _name;
  String _quantity;
  String _unit;
  DateTime _startDate;
  int _shelfLife;
  String _imageUrl;

  @override
  void initState() {
    super.initState();
    _name = widget._ingredient.name;
    _quantity = widget._ingredient.quantity;
    _unit = widget._ingredient.unit;
    _startDate = DateTime.now();
    _shelfLife = widget._ingredient.shelfLife;
    _imageUrl = widget._ingredient.imageUrl;
  }

  Future<void> _onSubmit() async {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      _groceryDB.addItem(Ingredient(
          name: _name,
          quantity: _quantity,
          unit: _unit,
          startDate: _startDate,
          shelfLife: _shelfLife,
          imageUrl: _imageUrl));
      _controller1.clear();
      _controller2.clear();
      _controller3.clear();
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
      appBar: AppBar(title: Text('Add ' + widget._ingredient.name)),
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
                      child: Image(
                          image: NetworkImage(widget._ingredient.imageUrl))),
                  SizedBox(height: 15.0),
                  Text(widget._ingredient.name, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 15.0),
                  TextFormField(
                    controller: _controller1,
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
                    controller: _controller2,
                    key: ValueKey("unit"),
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Enter Unit (Optional)'),
                    onChanged: (val) {
                      setState(() => _unit = val);
                    },
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    controller: _controller3,
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
