import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:ready_set_cook/services/recipes_database.dart';
import 'package:ready_set_cook/screens/recipes/edit_recipe.dart';
import 'package:ready_set_cook/screens/recipes/view_recipe_tile.dart';
import 'package:ready_set_cook/models/nutrition.dart';
import 'package:ready_set_cook/screens/recipes/delete_confirmation.dart';
import 'package:ready_set_cook/screens/recipes/rate_recipe.dart';
import 'package:ready_set_cook/screens/recommend/view_recommend_recipe_tile.dart';

class ViewStoredRecommendedRecipe extends StatefulWidget {
  final Function toggleView;
  String recipeId = "";
  String name = "";
  String imageUrl = "";
  String uid = "";
  bool fav = false;
  ViewStoredRecommendedRecipe(
      this.recipeId, this.name, this.imageUrl, this.fav, this.uid,
      {this.toggleView});
  @override
  _ViewStoredRecommendedRecipeState createState() =>
      _ViewStoredRecommendedRecipeState();
}

class _ViewStoredRecommendedRecipeState
    extends State<ViewStoredRecommendedRecipe> {
  @override
  void initState() {
    super.initState();
    this.recipeId = widget.recipeId;
    this.imageUrl = widget.imageUrl;
    this.fav = widget.fav;
    this.name = widget.name;
    this.uid = widget.uid;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String recipeId = "";
  String name = "";
  String quantity = "";
  String unit = "";
  String instruction = "";
  String imageUrl = "";
  String uid;
  bool fav = false;
  List<Ingredient> _ingredientsList = [];
  List<String> _instructionsList = [];
  List<int> _ins_index_List = [];
  Nutrition nutrition;
  callme() async {
    await Future.delayed(Duration(seconds: 3));
  }

  void sort_Instruction() {
    List<String> temp = [];
    for (int i = 0; i < _ins_index_List.length; i++) {
      int j = _ins_index_List.indexOf(i);
      if (j == -1) {
        return;
      }
      temp.add(_instructionsList[j]);
    }
    print(temp);
    _instructionsList = temp;
  }

  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser.uid;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('allRecipes')
            .doc(recipeId)
            .collection("ingredients")
            .snapshots(),
        builder: (ctx, ingredientSnapshot) {
          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('allRecipes')
                .doc(recipeId)
                .collection("instructions")
                .snapshots(),
            builder: (ctx, instructionSnapshot) {
              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('allRecipes')
                    .doc(recipeId)
                    .collection("nutrition")
                    .snapshots(),
                builder: (ctx, nutritionSnapshot) {
                  if (ingredientSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (instructionSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (nutritionSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  instructionSnapshot.data.documents.forEach((instruction) {
                    _instructionsList.add(instruction['instruction']);
                    _ins_index_List.add(instruction['index']);
                  });
                  sort_Instruction();
                  ingredientSnapshot.data.documents.forEach((ingredient) {
                    _ingredientsList.add(new Ingredient(
                        name: ingredient['name'],
                        quantity: ingredient['quantity'],
                        unit: ingredient['unit']));
                  });

                  nutritionSnapshot.data.documents.forEach((nut) {
                    nutrition = Nutrition(
                        calories: nut['Calories'],
                        protein: nut['Protein'],
                        totalCarbs: nut['Total Carbohydrate'],
                        totalFat: nut['Total Fat']);
                  });

                  return Scaffold(
                    backgroundColor: Colors.blue[50],
                    appBar: AppBar(
                      title: Text(name),
                      elevation: 0,
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerDocked,
                    floatingActionButton: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            ])),
                    body: Container(
                      child: ViewRecommendRecipeTile(
                          ingredient: _ingredientsList,
                          instruction: _instructionsList,
                          nutrition: nutrition,
                          imageUrl: imageUrl,
                          fav: fav,
                          recipeId: recipeId),
                    ),
                  );
                },
              );
            },
          );
        });
  }
}
