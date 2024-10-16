import 'package:flutter/material.dart';
import 'package:ready_set_cook/models/ingredient.dart';

class AddIngredientPage extends StatefulWidget {
  final String instruction;
  AddIngredientPage({this.instruction});
  final _formKey = GlobalKey<FormState>();

  @override
  _AddIngredientPage createState() => _AddIngredientPage();
}

class _AddIngredientPage extends State<AddIngredientPage> {
  String _ingredientName = "";
  String _quantity = "";
  String _unit = "";
  final _ingredKey = GlobalKey<FormState>();

  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller1.clear();
    _controller2.clear();
    _controller3.clear();
    return new Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Add New Ingredient"),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Form(
            key: _ingredKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 24,
                ),
                TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Enter Ingredient",
                      border: new OutlineInputBorder(
                        borderSide: new BorderSide(),
                      ),
                    ),
                    controller: _controller1,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter an ingredient";
                      }
                      if (value.length > 16) {
                        return "Ingredient name too long";
                      }
                      return null;
                    }),
                SizedBox(
                  height: 24,
                ),
                TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Enter Quantity Here",
                      border: new OutlineInputBorder(
                        borderSide: new BorderSide(),
                      ),
                    ),
                    controller: _controller2,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter a quantity";
                      }

                      if (!isNumeric(value)) {
                        return "Please enter an integer";
                      }

                      return null;
                    }),
                SizedBox(
                  height: 24,
                ),
                TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Enter Unit Here",
                      border: new OutlineInputBorder(
                        borderSide: new BorderSide(),
                      ),
                    ),
                    controller: _controller3,
                    validator: (value) {
                      if (value.length > 9) {
                        return "Unit of Measure Invalid";
                      }
                      return null;
                    }),
                SizedBox(
                  height: 24,
                ),
                RaisedButton(
                  color: Colors.blue[400],
                  child: Text(
                    'Add Ingredient',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (_ingredKey.currentState.validate()) {
                      final newIngredient = new Ingredient(
                          name: _controller1.text,
                          quantity: _controller2.text,
                          unit: _controller3.text);
                      _controller1.clear();
                      _controller2.clear();
                      _controller3.clear();

                      Navigator.of(context).pop(newIngredient);
                    }
                  },
                )
              ],
            ),
          )),
    );
  }
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.parse(s, (e) => null) != null;
}
