import 'package:flutter/material.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:ready_set_cook/screens/storage/common_edit.dart';

class IngredientTile extends StatefulWidget {
  final Ingredient _ingredient;

  IngredientTile(this._ingredient);

  @override
  _IngredientTileState createState() => _IngredientTileState();
}

class _IngredientTileState extends State<IngredientTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: GestureDetector(
            child: Column(
              children: <Widget>[
                CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 24,
                    backgroundImage: NetworkImage(widget._ingredient.imageUrl)),
                Text(widget._ingredient.name)
              ],
            ),
            onTap: () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CommonEdit(widget._ingredient)));
              });
            }));
  }
}
