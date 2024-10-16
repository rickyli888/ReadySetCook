import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/recipes/recipe.dart';
import 'package:ready_set_cook/services/recipes_database.dart';
import 'package:ready_set_cook/screens/recommend/view_recommended_recipe.dart';
import 'package:ready_set_cook/screens/recommend/view_stored_recommended_recipe.dart';

class FilteredRecipe extends StatelessWidget {
  final recipeId;
  final ingredientArray;
  final name;
  final rating;
  final imageUrl;
  final fav;
  final uid;

  FilteredRecipe(
      {this.recipeId,
      this.ingredientArray,
      this.name,
      this.rating,
      this.imageUrl,
      this.fav,
      this.uid});

  @override
  Widget build(BuildContext context) {
    bool contained = false;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('allRecipes')
          .doc(recipeId)
          .collection('ingredients')
          .snapshots(),
      builder: (context, ingSnapshot) {
        if (ingSnapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else {
          var ingDocs = ingSnapshot.data.documents;
          for (var i = 0; i < ingDocs.length; i++) {
            var ingredientName = ingDocs[i]['name'];
            if (ingredientArray.contains(ingredientName) ||
                ingredientArray.contains(ingredientName.toLowerCase())) {
              contained = true;
            }
            // return CompareWithStorage(ingredientName: ingredientName);
          }
        }
        return (contained == true)
            ? RecipeItem(
                name: name,
                rating: rating,
                recipeId: recipeId,
                imageUrl: imageUrl,
                fav: fav,
                uid: uid,
              )
            : SizedBox();
      },
    );
  }
}

class RecipeItem extends StatelessWidget {
  final String name;
  final double rating;
  final String recipeId;
  final String imageUrl;
  final bool fav;
  final String uid;

  const RecipeItem(
      {Key key,
      this.name,
      this.rating,
      this.recipeId,
      this.imageUrl,
      this.fav,
      this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = Colors.red;
    var _fav = fav;
    var _name = name;
    var recipeDB = RecipesDatabaseService(uid: uid);

    final ThemeData themeData = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (context) => ViewStoredRecommendedRecipe(
                    recipeId, name, imageUrl, fav, uid)))
            .then((value) async {
          _name = await recipeDB.getRecipeName(recipeId);
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Center(
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: (imageUrl == null)
                      ? Image(
                          image: NetworkImage(
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png"))
                      : Image(image: NetworkImage(imageUrl)),
                ))
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text(
                  " $_name",
                  style: themeData.textTheme.headline5,
                ),
              ],
            ),
            SizedBox(height: 7),
            Row(children: [
              Text(
                "  $rating / 5.0",
                style: themeData.textTheme.subtitle1,
              ),
              _buildRatingStar(rating)
            ]),
          ],
        ),
      ),
    );
  }
}

Widget _buildRatingStar(rating) {
  List<Widget> icons = [];
  double i = 0;
  while (rating - i >= 0.75) {
    icons.add(new Icon(Icons.star, color: Colors.blue));
    i = i + 1;
  }

  if (rating - i >= 0.25) {
    icons.add(new Icon(Icons.star_half, color: Colors.blue));
  }

  while (icons.length < 5) {
    icons.add(new Icon(Icons.star_border, color: Colors.grey));
  }

  return new Padding(
    padding: EdgeInsets.fromLTRB(10, 0, 0, 3),
    child: new Row(children: icons),
  );
}
