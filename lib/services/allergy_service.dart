import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:ready_set_cook/models/user.dart';
import 'package:ready_set_cook/models/allergies.dart';

class AllergyDatabase {
  User _user;
  DocumentReference _allergyDoc;
  final _allergyReference =
      FirebaseFirestore.instance.collection("dietary preferences");

  AllergyDatabase(context) {
    _user = Provider.of<User>(context);
    if (_allergyReference.doc(_user.uid) == null) {
      _allergyReference.doc(_user.uid).set({"count": 0});
    }
    _allergyDoc = _allergyReference.doc(_user.uid);
  }

  void addAllergy(DiePref preference) {
    _allergyDoc.collection("allergyList").add({
      "allergy": preference.allergy,
    });
  }

  void deleteAllergy(String id) {
    _allergyDoc.collection("allergyList").doc(id).delete();
  }

  Stream<QuerySnapshot> getAllergySnap() {
    return _allergyDoc.collection("allergyList").snapshots();
  }
}
