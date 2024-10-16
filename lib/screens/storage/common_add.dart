import 'package:flutter/material.dart';
import 'package:ready_set_cook/services/grocery.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:ready_set_cook/shared/common_ingredients.dart';
import 'package:ready_set_cook/screens/storage/widget/ingredient_tile.dart';

class CommonAdd extends StatefulWidget {
  @override
  _CommonAddState createState() => _CommonAddState();
}

class _CommonAddState extends State<CommonAdd> {
  GroceryDatabase _groceryDB = null;

  Widget build(BuildContext context) {
    if (_groceryDB == null) {
      _groceryDB = GroceryDatabase(context);
    }

    CommonIngredient commonIngredient = CommonIngredient();
    return Scaffold(
        backgroundColor: Colors.blue[50],
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            ExpansionTile(
              title: Text("Fruit"),
              children: [
                GridView.count(
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    children: <Widget>[
                      for (Ingredient item in commonIngredient.commonFruits)
                        IngredientTile(item)
                    ]),
              ],
            ),
            ExpansionTile(
              title: Text("Vegetables"),
              children: [
                GridView.count(
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    children: <Widget>[
                      for (Ingredient item in commonIngredient.commonVegetables)
                        IngredientTile(item)
                    ]),
              ],
            ),
            ExpansionTile(
              title: Text("Meat and Seafood"),
              children: [
                GridView.count(
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    children: <Widget>[
                      for (Ingredient item
                          in commonIngredient.commonMeatAndSeafood)
                        IngredientTile(item)
                    ]),
              ],
            ),
            ExpansionTile(
              title: Text("Others"),
              children: [
                GridView.count(
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    children: <Widget>[
                      for (Ingredient item
                          in commonIngredient.commonOtherIngredient)
                        IngredientTile(item)
                    ]),
              ],
            ),
          ],
        )));
  }
}
