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

class ViewRecipe extends StatefulWidget {
  final Function toggleView;
  String recipeId = "";
  String name = "";
  String imageUrl = "";
  String uid = "";
  bool fav = false;
  ViewRecipe(this.recipeId, this.name, this.imageUrl, this.fav, this.uid,
      {this.toggleView});
  @override
  _ViewRecipeState createState() => _ViewRecipeState();
}

class _ViewRecipeState extends State<ViewRecipe> {
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
            .collection('recipes')
            .doc(uid)
            .collection("recipesList")
            .doc(recipeId)
            .collection("ingredients")
            .snapshots(),
        builder: (ctx, ingredientSnapshot) {
          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('recipes')
                .doc(uid)
                .collection("recipesList")
                .doc(recipeId)
                .collection("instructions")
                .snapshots(),
            builder: (ctx, instructionSnapshot) {
              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('recipes')
                    .doc(uid)
                    .collection("recipesList")
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
                  print("Outside for each");
                  nutritionSnapshot.data.documents.forEach((nut) {
                    print("inside for each");
                    print("calories:" + nut["Calories"]);
                    nutrition = Nutrition(
                        calories: nut['Calories'],
                        protein: nut['Protein'],
                        totalCarbs: nut['Total Carbohydrate'],
                        totalFat: nut['Total Fat']);
                  });
                  print("after for each");

                  return Scaffold(
                    backgroundColor: Colors.blue[50],
                    appBar: AppBar(
                      title: Text(name),
                      elevation: 0,
                      actions: <Widget>[
                        FlatButton(
                          minWidth: 20,
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          onPressed: () async {
                            DeleteConfirmation(context)
                                .showDeleteConfirmation(context, recipeId);
                          },
                        ),
                      ],
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerDocked,
                    floatingActionButton: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FloatingActionButton.extended(
                                  heroTag: "edit",
                                  icon: Icon(Icons.edit),
                                  label: Text("Edit",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14)),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditRecipe(
                                                ingredient: _ingredientsList,
                                                instruction: _instructionsList,
                                                ins_index: _ins_index_List,
                                                nutrition: nutrition,
                                                imageUrl: imageUrl,
                                                fav: fav,
                                                recipeId: recipeId,
                                                name: name))).then((value) {
                                      setState(() {
                                        RecipesDatabaseService recipeDB =
                                            RecipesDatabaseService(uid: uid);
                                        recipeDB
                                            .getRecipeName(recipeId)
                                            .then((value) {
                                          setState(() {
                                            name = value;
                                          });

                                          _ingredientsList.clear();
                                          _instructionsList.clear();
                                          _ins_index_List.clear();
                                        });
                                      });
                                    });
                                  }),
                              FloatingActionButton.extended(
                                heroTag: "rate",
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: BorderSide(color: Colors.blue)),
                                icon: Icon(Icons.star,
                                    color: Colors.white, size: 20),
                                label: Text(
                                  'Rate',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RatingBar(recipeId)));
                                },
                              )
                            ])),
                    body: Container(
                      child: ViewRecipeTile(
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
