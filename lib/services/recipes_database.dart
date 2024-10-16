import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ready_set_cook/models/recipe.dart';

class RecipesDatabaseService {
  // uid of user
  String uid;
  RecipesDatabaseService({this.uid});

  // obtains instance of the recipes collection from firestore
  final CollectionReference recipeCollection =
      FirebaseFirestore.instance.collection('recipes');

  final CollectionReference allRecipesCollection =
      FirebaseFirestore.instance.collection('allRecipes');

  String _recipeName;
  double _recipeRating;
  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  Future favRecipe(String recipeId) async {
    String id;

    CollectionReference _documentRef =
        recipeCollection.doc(uid).collection('recipesList');
    return _documentRef.get().then((ds) {
      if (ds != null) {
        ds.docs.forEach((recipe) {
          id = recipe['recipeId'];
          if (id == recipeId) {
            return FirebaseFirestore.instance
                .collection('recipes')
                .doc(uid)
                .collection("recipesList")
                .doc(recipe.id)
                .set({
              "recipeId": recipeId,
              "fav": true,
              "imageUrl": recipe["imageUrl"],
              "name": recipe["name"],
              "numRatings": recipe["numRatings"],
              "rating": recipe["rating"]
            });
          }
        });
      }
    });
  }

  Future unFavRecipe(String recipeId) async {
    String id;

    CollectionReference _documentRef =
        recipeCollection.doc(uid).collection('recipesList');
    return _documentRef.get().then((ds) {
      if (ds != null) {
        ds.docs.forEach((recipe) {
          id = recipe['recipeId'];
          if (id == recipeId) {
            return FirebaseFirestore.instance
                .collection('recipes')
                .doc(uid)
                .collection("recipesList")
                .doc(recipe.id)
                .set({
              "recipeId": recipeId,
              "fav": false,
              "imageUrl": recipe["imageUrl"],
              "name": recipe["name"],
              "numRatings": recipe["numRatings"],
              "rating": recipe["rating"]
            });
          }
        });
      }
    });
  }

  addRecipe(String recipeId) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("allRecipes")
        .doc(recipeId)
        .get();
    print("yep");
    QuerySnapshot ingredient = await FirebaseFirestore.instance
        .collection("allRecipes")
        .doc(recipeId)
        .collection("ingredients")
        .get();
    QuerySnapshot instruction = await FirebaseFirestore.instance
        .collection("allRecipes")
        .doc(recipeId)
        .collection("instructions")
        .get();
    QuerySnapshot nutrition = await FirebaseFirestore.instance
        .collection("allRecipes")
        .doc(recipeId)
        .collection("nutrition")
        .get();
    String imageUrl = snapshot.get("imageUrl");
    String name = snapshot.get("name");
    int numRating = snapshot.get("numRatings");
    var temp = snapshot.get('rating');
    double rating = roundDouble(temp.toDouble(), 1);
    CollectionReference _documentRef =
        recipeCollection.doc(uid).collection('recipesList');
    _documentRef.doc(recipeId).set({
      "imageUrl": imageUrl,
      "name": name,
      "numRatings": numRating,
      "rating": rating,
      "recipeId": recipeId,
      "fav": false
    });
    ingredient.docs.forEach((ing) {
      _documentRef.doc(recipeId).collection("ingredients").add({
        "name": ing.get("name"),
        "quantity": ing.get("quantity"),
        "unit": ing.get("unit")
      });
    });
    instruction.docs.forEach((ins) {
      _documentRef.doc(recipeId).collection("instructions").add(
          {"index": ins.get("index"), "instruction": ins.get("instruction")});
    });
    nutrition.docs.forEach((nut) {
      _documentRef.doc(recipeId).collection("nutrition").add({
        "Calories": nut.get("Calories"),
        "Protein": nut.get("Protein"),
        "Total Fat": nut.get("Total Fat"),
        "Total Carbohydrate": nut.get("Total Carbohydrate")
      });
    });
  }

  Future updateRecipe(String newName, String recipeId) async {
    return await recipeCollection.doc(recipeId).update({
      "name": newName,
    });
  }

  deleteRecipe(String recipeId, String uid) {
    FirebaseFirestore.instance
        .collection('recipes')
        .doc(uid)
        .collection('recipesList')
        .snapshots()
        .listen((snapshot) {
      snapshot.docs.forEach((recipeIdField) {
        if (recipeIdField['recipeId'] == recipeId) {
          FirebaseFirestore.instance
              .collection('recipes')
              .doc(uid)
              .collection("recipesList")
              .doc(recipeIdField.id)
              .delete();
          FirebaseFirestore.instance
              .collection('recipes')
              .doc(uid)
              .collection("recipesList")
              .doc(recipeId)
              .collection("ingredients")
              .get()
              .then((snapshot) {
            for (DocumentSnapshot ds in snapshot.docs) {
              ds.reference.delete();
            }
          });
          FirebaseFirestore.instance
              .collection('recipes')
              .doc(uid)
              .collection("recipesList")
              .doc(recipeId)
              .collection("instructions")
              .get()
              .then((snapshot) {
            for (DocumentSnapshot ds in snapshot.docs) {
              ds.reference.delete();
            }
          });
          FirebaseFirestore.instance
              .collection('recipes')
              .doc(uid)
              .collection("recipesList")
              .doc(recipeId)
              .collection("nutrition")
              .get()
              .then((snapshot) {
            for (DocumentSnapshot ds in snapshot.docs) {
              ds.reference.delete();
            }
          });
        }
      });
    });
  }

  Future addCustomRecipe(Recipe recipe) async {
    int ins_index = 0;
    recipe.ingredients.forEach((ing) {
      allRecipesCollection
          .doc(recipe.recipeId)
          .collection("ingredients")
          .add({"name": ing.name, "quantity": ing.quantity, "unit": ing.unit});
    });

    recipe.instructions.forEach((ins) {
      allRecipesCollection
          .doc(recipe.recipeId)
          .collection("instructions")
          .add({"instruction": ins, "index": ins_index});
      ins_index += 1;
    });

    allRecipesCollection.doc(recipe.recipeId).collection("nutrition").add({
      "Calories": recipe.nutrition.calories,
      "Protein": recipe.nutrition.protein,
      "Total Fat": recipe.nutrition.totalFat,
      "Total Carbohydrate": recipe.nutrition.totalCarbs,
    });
    allRecipesCollection.doc(recipe.recipeId).collection("uids").add({});

    await allRecipesCollection.doc(recipe.recipeId).set({
      "recipeId": recipe.recipeId,
      "name": recipe.name,
      "rating": recipe.rating,
      "numRatings": recipe.numRatings,
      "imageUrl": recipe.imageUrl,
    });
    addRecipe(recipe.recipeId);
    recipe.ingredients.clear();
    recipe.instructions.clear();
  }

  Future getRecipesHelper(QueryDocumentSnapshot qds) async {
    DocumentSnapshot recipeSnapshot =
        await allRecipesCollection.doc(qds.get('recipeId')).get();
    _recipeName = recipeSnapshot.get('name');
    _recipeRating = recipeSnapshot.get('rating');
  }

  // list of recipes from snapshot
  List<Recipe> _recipesList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      getRecipesHelper(doc);
      return Recipe(
        recipeId: doc.get('recipeId'),
        name: _recipeName,
        ingredients: null,
        instructions: null,
        rating: _recipeRating,
      );
    }).toList();
  }

  // get recipes stream
  Stream<List<Recipe>> get recipes {
    return recipeCollection
        .doc(uid)
        .collection("recipesList")
        .snapshots()
        .map(_recipesList);
  }

  Future getRecipeName(String recipeId) async {
    var name = await FirebaseFirestore.instance
        .collection('recipes')
        .doc(uid)
        .collection('recipesList')
        .doc(recipeId)
        .get();
    return name.get('name');
  }
}
