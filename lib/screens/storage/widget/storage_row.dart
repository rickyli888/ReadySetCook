import 'package:flutter/material.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:ready_set_cook/screens/storage/view.dart';

class StorageRow extends StatefulWidget {
  final Ingredient _ingredient;

  StorageRow(this._ingredient);

  @override
  _StorageRowState createState() => _StorageRowState();
}

class _StorageRowState extends State<StorageRow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 38,
                  backgroundImage: (widget._ingredient.imageUrl != null)
                      ? NetworkImage(widget._ingredient.imageUrl)
                      : NetworkImage(
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png"),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  width: 110,
                  child: Text(
                    widget._ingredient.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: 35,
                  child: Text(widget._ingredient.quantity.toString(),
                      style: TextStyle(fontSize: 20)),
                ),
                Container(
                  width: 50,
                  child: (widget._ingredient.unit != null)
                      ? Text(widget._ingredient.unit,
                          style: TextStyle(fontSize: 20))
                      : Text(""),
                ),
                Container(
                    child: (DateTime.now()
                                .difference(widget._ingredient.startDate)
                                .inDays <
                            widget._ingredient.shelfLife)
                        ? (DateTime.now()
                                    .difference(widget._ingredient.startDate)
                                    .inDays <
                                widget._ingredient.shelfLife - 5
                            ? IconButton(
                                icon: Icon(Icons.check),
                                iconSize: 30.0,
                                color: Colors.green,
                                onPressed: () {},
                              )
                            : IconButton(
                                icon: Icon(Icons.warning_amber_outlined),
                                iconSize: 30.0,
                                color: Colors.yellow[800],
                                onPressed: () {}))
                        : IconButton(
                            icon: Icon(Icons.close),
                            iconSize: 30.0,
                            color: Colors.red,
                            onPressed: () {})),
              ],
            )),
        onTap: () {
          setState(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => View(widget._ingredient)));
          });
        });
  }
}
