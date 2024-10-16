import 'package:provider/provider.dart';
import 'package:ready_set_cook/models/user.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroceryDatabase {
  User _user;
  DocumentReference _groceryDoc;
  final _groceryReference = FirebaseFirestore.instance.collection("grocery");

  GroceryDatabase(context) {
    _user = Provider.of<User>(context);
    if (_groceryReference.doc(_user.uid) == null) {
      _groceryReference.doc(_user.uid).set({"count": 0});
    }
    _groceryDoc = _groceryReference.doc(_user.uid);
  }

  void addItem(Ingredient ingredient) {
    DateTime deadline = ingredient.startDate.add(Duration(days: ingredient.shelfLife));
    _groceryDoc.collection("groceryList").add({
      "name": ingredient.name,
      "quantity": ingredient.quantity,
      "unit": ingredient.unit,
      "startDate": ingredient.startDate,
      "shelfLife": ingredient.shelfLife,
      "deadline": deadline,
      "imageUrl": ingredient.imageUrl
    });
  }

  void deleteItem(String id) {
    _groceryDoc.collection("groceryList").doc(id).delete();
  }

  void updateItem(Ingredient ingredient) {
    DateTime deadline = ingredient.startDate.add(Duration(days: ingredient.shelfLife));
    _groceryDoc.collection("groceryList").doc(ingredient.id).update({
      "name": ingredient.name,
      "quantity": ingredient.quantity,
      "unit": ingredient.unit,
      "startDate": ingredient.startDate,
      "shelfLife": ingredient.shelfLife,
      "deadline": deadline,
      "imageUrl": ingredient.imageUrl
    });
  }

  Stream<QuerySnapshot> getGrocerySnap() {
    return _groceryDoc
        .collection("groceryList")
        .orderBy('deadline')
        .snapshots();
  }
}
