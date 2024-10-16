import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ready_set_cook/services/recipes_database.dart';

class DeleteConfirmation extends StatelessWidget {
  DeleteConfirmation(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  showDeleteConfirmation(BuildContext context, String recipeId) {
    final uid = FirebaseAuth.instance.currentUser.uid;
    final recipeDB = RecipesDatabaseService(uid: uid);

    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget confirmButton = FlatButton(
      child: Text("Confirm", style: TextStyle(color: Colors.red)),
      onPressed: () {
        Navigator.of(context).pop();
        recipeDB.deleteRecipe(recipeId, uid);
        Navigator.of(context).pop();
      },
    );
    AlertDialog confirmation = AlertDialog(
      title: Text("Are you sure?"),
      content: Text("Delete this recipe from your list"),
      actions: [
        cancelButton,
        confirmButton,
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return confirmation;
        });
  }
}
