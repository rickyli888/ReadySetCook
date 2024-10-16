import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:ready_set_cook/models/user.dart';
import 'package:ready_set_cook/models/error.dart';

class ErrorDatabase {
  User _user;
  DocumentReference _errorDoc;
  final _errorReference = FirebaseFirestore.instance.collection("error");

  ErrorDatabase(context) {
    _user = Provider.of<User>(context);
    if (_errorReference.doc(_user.uid) == null) {
      _errorReference.doc(_user.uid).set({"count": 0});
    }
    _errorDoc = _errorReference.doc(_user.uid);
  }

  void addError(ReportedError error) {
    _errorDoc.collection("errorList").add({
      "title": error.title,
      "problem": error.problem,
    });
  }

  Stream<QuerySnapshot> getErrorSnap() {
    return _errorDoc.collection("errorList").snapshots();
  }
}
