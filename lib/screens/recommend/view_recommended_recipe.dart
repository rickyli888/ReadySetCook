import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:ready_set_cook/models/nutrition.dart';
import 'package:ready_set_cook/models/recipe.dart';
import 'package:ready_set_cook/services/recipes_database.dart';
import 'package:uuid/uuid.dart';

import 'recommend.dart' as recommend;

// Ingredient Model from API for Mapping
class apiIngredient {
  final String name;
  final amount;

  apiIngredient({this.name, this.amount});

  factory apiIngredient.fromMap(Map<String, dynamic> json) {
    return apiIngredient(name: json["name"], amount: json["amount"]);
  }
}

// Ingredient Mapper
class IngredientMapper {
  final List<apiIngredient> ingredientLists;

  IngredientMapper({this.ingredientLists});

  factory IngredientMapper.fromMap(Map<String, dynamic> map) {
    List<apiIngredient> ingredients = [];
    if (map['ingredients'] != null) {
      map['ingredients'].forEach(
          (ingredient) => ingredients.add(apiIngredient.fromMap(ingredient)));
    }
    return IngredientMapper(
      ingredientLists: ingredients,
    );
  }
}

class ViewRecommendedRecipe extends StatefulWidget {
  final Function toggleView;
  String recipeId = "";
  String name = "";
  String imageType = "";
  double spoonRating;

  ViewRecommendedRecipe(
      {this.recipeId,
      this.name,
      this.imageType,
      this.spoonRating,
      this.toggleView});

  @override
  _ViewRecommendedRecipeState createState() => _ViewRecommendedRecipeState();
}

class _ViewRecommendedRecipeState extends State<ViewRecommendedRecipe> {
  String recipeId = "";
  String recipeName = "";
  String imageType = "";
  double spoonRating;

  @override
  void initState() {
    super.initState();
    this.recipeId = widget.recipeId;
    this.imageType = widget.imageType;
    this.recipeName = widget.name;
    this.spoonRating = widget.spoonRating;
    getIngredients();
    getInstructions();
    getNutrition();
    setState(() {});
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Nutrition nutrition;
  bool fav = false;

  String apiURL = 'https://api.spoonacular.com';
  String apiKey = recommend.apiKey;

  // Variables for Ingredients
  List<apiIngredient> apiIngredients = [];
  List<String> names = [];
  List<Ingredient> finalIngredientList = [];

  //Variable for instructionList
  List<String> instructionList = [];

  // Variables for Calories
  String calories = "Info Not Available";
  String protein = "Info Not Available";
  String totalFat = "Info Not Available";
  String totalCarbs = "Info Not Available";

  Future<void> _createRecipe() async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user.uid;
    var recipeDB = RecipesDatabaseService(uid: uid);
    this.spoonRating = 5.0 * (this.spoonRating * 0.01);
    double rating = double.parse((this.spoonRating).toStringAsFixed(1));
    debugPrint(rating.toString());
    String imageUrl = "https://spoonacular"
            ".com/recipeImages/" +
        this.recipeId +
        "-556x370"
            "." +
        this.imageType;

    nutrition = new Nutrition(
        calories: this.calories,
        protein: this.protein,
        totalCarbs: this.totalCarbs,
        totalFat: this.totalFat);
    var _recipeId = Uuid().v4();
    debugPrint(_recipeId);
    debugPrint(this.recipeName);
    debugPrint(finalIngredientList.length.toString());
    debugPrint(instructionList.length.toString());
    debugPrint(nutrition.toString());
    debugPrint(rating.toString());
    debugPrint(imageUrl);
    debugPrint(fav.toString());

    recipeDB.addCustomRecipe(new Recipe(
        recipeId: _recipeId,
        name: this.recipeName,
        ingredients: this.finalIngredientList,
        instructions: this.instructionList,
        nutrition: this.nutrition,
        rating: rating,
        numRatings: 1,
        imageUrl: imageUrl,
        fav: fav));
    setState(() {});
    Navigator.of(context).pop();
  }

  void getInstructions() async {
    //https://api.spoonacular.com/recipes/324694/analyzedInstructions
    var response = await http
        .get('$apiURL/recipes/$recipeId/analyzedInstructions?apiKey=$apiKey');

    if (response.statusCode == 200) {
      List<dynamic> output = jsonDecode(response.body);
      List<dynamic> outputCheck = output[0]["steps"];
      for (int i = 0; i < outputCheck.length; i++) {
        this.instructionList.add(outputCheck[i]["step"]);
      }
      setState(() {});
    } else {
      debugPrint("API Response Error");
      throw Exception('Failed to load Instructions');
    }
  }

  void getNutrition() async {
    var response = await http.get("https://api.spoonacular"
        ".com/recipes/$recipeId/nutritionWidget.json?apiKey=$apiKey");
    //await http.get('$apiURL/recipes/$recipeId/ingredientWidget.json');

    if (response.statusCode == 200) {
      Map<String, dynamic> nutritionData = jsonDecode(response.body);
      if (nutritionData["carbs"] != null) {
        this.totalCarbs = nutritionData["carbs"];
      }
      if (nutritionData["fat"] != null) {
        this.totalFat = nutritionData["fat"];
      }
      if (nutritionData["calories"] != null) {
        this.calories = nutritionData["calories"];
      }
      if (nutritionData["protein"] != null) {
        this.protein = nutritionData["protein"];
      }
      setState(() {});
    } else {
      debugPrint("API Response Error");
      throw Exception('Failed to load Ingredients');
    }
  }

  void getIngredients() async {
    //https://api.spoonacular.com/recipes/1003464/ingredientWidget.json
    var response = await http.get("https://api.spoonacular"
        ".com/recipes/$recipeId/ingredientWidget.json?apiKey=$apiKey");
    //await http.get('$apiURL/recipes/$recipeId/ingredientWidget.json');

    if (response.statusCode == 200) {
      Map<String, dynamic> recipesData = jsonDecode(response.body);
      IngredientMapper ingMapper = IngredientMapper.fromMap(recipesData);
      apiIngredients = ingMapper.ingredientLists;
      apiIngredients.forEach((element) {
        this.finalIngredientList.add(new Ingredient(
            name: element.name,
            quantity: element.amount["us"]["value"].round().toString(),
            unit: element.amount["us"]["unit"]));
      });
    } else {
      debugPrint("API Response Error");
      throw Exception('Failed to load Ingredients');
    }
  }

  Widget _offsetPopup() => PopupMenuButton<int>(
        onSelected: (pressed) {
          if (pressed == 1) {
            debugPrint("Created Recipe");
            _createRecipe();
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text(
              "Add to Recipe List",
              style: TextStyle(
                  color: Colors.lightBlueAccent, fontWeight: FontWeight.w700),
            ),
          ),
        ],
        icon: ClipOval(
          child: Material(
            color: Colors.blue, // button color
            child: InkWell(
              child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20,
                  )),
            ),
          ),
        ),
        offset: Offset(0, 100),
      );

  // Build Widget
  Widget build(BuildContext context) {
    // List of Instructions from API Recipe

    String imageUrl = "https://upload.wikimedia"
        ".org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png";
    if (imageType == null) {
      imageUrl = "https://upload.wikimedia"
          ".org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png";
    } else {
      imageUrl = "https://spoonacular"
              ".com/recipeImages/" +
          recipeId +
          "-480x360." +
          imageType;
    }

    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text(this.recipeName),
        elevation: 0,
      ),
      body: Container(
        child: ListView(physics: BouncingScrollPhysics(), children: <Widget>[
          Container(
              child: Column(children: <Widget>[
            Stack(
              children: [
                (imageUrl == null)
                    ? Image(
                        image: NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png"))
                    : Image(image: NetworkImage(imageUrl)),
                Positioned(
                  right: 30,
                  top: 10,
                  child: _offsetPopup(),
                ),
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
                    for (int i = 0; i < (this.finalIngredientList.length); i++)
                      Table(
                          border: TableBorder.symmetric(
                              inside: BorderSide.none,
                              outside: BorderSide.none),
                          defaultColumnWidth: FixedColumnWidth(180),
                          children: [
                            TableRow(children: [
                              TableCell(
                                  child: Text(this.finalIngredientList[i].name,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 19, height: 1.8))),
                              TableCell(
                                  child: Text(
                                      (this.finalIngredientList[i].quantity)
                                              .toString() +
                                          ' ' +
                                          this.finalIngredientList[i].unit,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 19, height: 1.8))),
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
                    for (int i = 0; i < (instructionList.length); i++)
                      Table(
                          border: TableBorder.symmetric(
                              inside: BorderSide.none,
                              outside: BorderSide.none),
                          defaultColumnWidth: FixedColumnWidth(350),
                          children: [
                            TableRow(children: [
                              TableCell(
                                  child: Text(
                                (i + 1).toString() +
                                    ':  ' +
                                    this.instructionList[i],
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
                              this.calories +
                                  '\n' +
                                  this.protein +
                                  '\n' +
                                  this.totalCarbs +
                                  '\n' +
                                  this.totalFat +
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
        ]),
      ),
    );
  }
}
