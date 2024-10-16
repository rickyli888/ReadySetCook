import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:ready_set_cook/screens/storage/edit.dart';

class View extends StatefulWidget {
  final Ingredient _ingredient;
  View(this._ingredient);

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(title: Text("View " + widget._ingredient.name)),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Edit(widget._ingredient)),
            );
          },
          icon: Icon(Icons.edit),
          label: Text("Edit"),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
            (widget._ingredient.imageUrl == null)
                ? Image(
                    image: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png"))
                : Image(image: NetworkImage(widget._ingredient.imageUrl)),
            SizedBox(height: 20),
            Text(
                widget._ingredient.name +
                    "   " +
                    widget._ingredient.quantity.toString() +
                    " " +
                    widget._ingredient.unit,
                style: TextStyle(fontSize: 36)),
            SizedBox(height: 20),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Add Date: " +
                      DateFormat('Md').format(widget._ingredient.startDate),
                  style: TextStyle(fontSize: 20),
                )),
            SizedBox(height: 10),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Spoil in " +
                      (widget._ingredient.shelfLife -
                              DateTime.now()
                                  .difference(widget._ingredient.startDate)
                                  .inDays)
                          .toString() +
                      " days",
                  style: TextStyle(fontSize: 20),
                ))
          ])),
        ));
  }
}
