import 'package:flutter/material.dart';

class AddInstructionsPage extends StatefulWidget {
  @override
  _AddInstructionsPage createState() => _AddInstructionsPage();
}

class _AddInstructionsPage extends State<AddInstructionsPage> {
  final _controller1 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _controller1.clear();
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Add an Instruction"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 15),
                TextFormField(
                      decoration: new InputDecoration(
                        labelText: "Enter Instruction Here",
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(
                          ),
                        ),
                      ),
                      controller: _controller1,
                      validator: (value){
                        if(value.isEmpty) {
                          return "Please enter an Instruction";
                        }
                        return null;
                      }
                ),
                SizedBox(
                  height: 24,
                ),
                RaisedButton(
                  color: Colors.blue[400],
                  child: Text(
                    'Add Instruction',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if(_formKey.currentState.validate()) {
                    Navigator.pop(context, _controller1.text);
                    }
                  },
                ),
              ],
            ),
          ),
    ),
      ));
  }
}
