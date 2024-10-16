import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:ready_set_cook/models/nutrition.dart';
import 'package:ready_set_cook/screens/recipes/border_icon.dart';
import 'package:ready_set_cook/services/recipes_database.dart';

class ViewRecommendRecipeTile extends StatefulWidget {
  final List<Ingredient> ingredient;
  final List<String> instruction;
  final Nutrition nutrition;
  final String imageUrl;
  final bool fav;
  final recipeId;
  ViewRecommendRecipeTile(
      {this.ingredient,
      this.instruction,
      this.nutrition,
      this.imageUrl,
      this.fav,
      this.recipeId});
  @override
  _ViewRecommendRecipeTileState createState() =>
      _ViewRecommendRecipeTileState();
}

class _ViewRecommendRecipeTileState extends State<ViewRecommendRecipeTile> {
  List<Ingredient> ingredient;
  List<String> instruction;
  Nutrition nutrition;
  String imageUrl;
  bool fav;
  String recipeId;

  @override
  void initState() {
    super.initState();
    this.recipeId = widget.recipeId;
    this.ingredient = widget.ingredient;
    this.instruction = widget.instruction;
    this.nutrition = widget.nutrition;
    this.imageUrl = widget.imageUrl;
    this.fav = widget.fav;
    this.recipeId = widget.recipeId;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    final user = FirebaseAuth.instance.currentUser;
    final uid = user.uid;
    var recipeDB = RecipesDatabaseService(uid: uid);

    return ListView(physics: BouncingScrollPhysics(), children: <Widget>[
      Container(
          child: Column(children: <Widget>[
        Stack(
          children: [
            (imageUrl == null)
                ? Image(
                    image: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png"))
                : Image(image: NetworkImage(imageUrl)),
          ],
        ),
        SizedBox(height: 15),
        Container(
            padding: EdgeInsets.all(12.0),
            child: Column(children: [
              Wrap(children: <Widget>[
                Text(
                  "Ingredients",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
                SizedBox(height: 50),
                for (int i = 0; i < (ingredient.length); i++)
                  Table(
                      border: TableBorder.symmetric(
                          inside: BorderSide.none, outside: BorderSide.none),
                      defaultColumnWidth: FixedColumnWidth(180),
                      children: [
                        TableRow(children: [
                          TableCell(
                              child: Text(ingredient[i].name,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 19, height: 1.8))),
                          TableCell(
                              child: Text(
                                  (ingredient[i].quantity).toString() +
                                      ' ' +
                                      ingredient[i].unit,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontSize: 19, height: 1.8))),
                        ])
                      ]),
                SizedBox(height: 100),
                Text(
                  "Instructions",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
                SizedBox(height: 50),
                for (int i = 0; i < (instruction.length); i++)
                  Table(
                      border: TableBorder.symmetric(
                          inside: BorderSide.none, outside: BorderSide.none),
                      defaultColumnWidth: FixedColumnWidth(350),
                      children: [
                        TableRow(children: [
                          TableCell(
                              child: Text(
                            (i + 1).toString() + ':  ' + instruction[i],
                            style: TextStyle(fontSize: 18, height: 1.8),
                            textAlign: TextAlign.left,
                          )),
                        ])
                      ]),
                SizedBox(height: 100),
                Text(
                  "Nutritional Facts (per serving)",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
                SizedBox(height: 50),
                Table(
                    border: TableBorder.symmetric(
                        inside: BorderSide.none, outside: BorderSide.none),
                    defaultColumnWidth: FixedColumnWidth(180),
                    children: [
                      TableRow(children: [
                        TableCell(
                            child: Text(
                          'Calories: ' +
                              '\nProtein: ' +
                              '\nTotal Carbs: ' +
                              '\nTotal Fat: ',
                          style: TextStyle(
                              // color: Colors.blue[700],
                              fontSize: 19,
                              height: 1.8),
                          textAlign: TextAlign.left,
                        )),
                        TableCell(
                            child: Text(
                          nutrition.calories.toString() +
                              '\n' +
                              nutrition.protein +
                              '\n' +
                              nutrition.totalCarbs +
                              '\n' +
                              nutrition.totalFat +
                              '\n',
                          style: TextStyle(fontSize: 19, height: 1.8),
                          textAlign: TextAlign.right,
                        )),
                      ])
                    ]),
                SizedBox(height: 200),
              ])
            ]))
      ]))
    ]);
  }
}
