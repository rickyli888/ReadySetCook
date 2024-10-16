import 'package:ready_set_cook/models/prac_ingredients.dart';
import 'package:flutter/material.dart';

class GroceryCard extends StatelessWidget {
  final Grocery grocery;
  GroceryCard({this.grocery});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(grocery.imageUrl),
            ),
            title: Text(grocery.name),
            subtitle: Text(grocery.quantity),
            trailing: Text(grocery.expDate),
          )
        ],
      ),
    );
  }
}
