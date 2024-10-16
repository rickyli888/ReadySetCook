import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart' as bar;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RatingBar extends StatefulWidget {
  var recipeId = "";
  RatingBar(this.recipeId);
  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  var _currentRating = null;
  var _numRating = null;
  var _avgRating = null;
  var _currentTotal = null;
  var recipeId;
  CollectionReference _allRecipes =
      FirebaseFirestore.instance.collection('allRecipes');

  @override
  void initState() {
    super.initState();
    this.recipeId = widget.recipeId;
  }

  Future<void> updateRating() {
    return _allRecipes
        .doc(recipeId)
        .update({'numRatings': _numRating, "rating": _avgRating}).catchError(
            (error) => print("Failed to update user: $error"));
  }

  Future<void> getOldRating() {
    return _allRecipes
        .doc(recipeId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        _numRating = documentSnapshot.get("numRatings");
        _avgRating = documentSnapshot.get("rating");
        _currentTotal = _numRating * _avgRating;
      }
    });
  }

  void _onSubmit() async {
    if (_currentRating == null) {
      print("problem with getting new rating");
    }

    await getOldRating();

    if (_numRating == null || _avgRating == null) {
      print("problem getting old datas");
    }

    _numRating = _numRating + 1;
    _currentTotal = _currentTotal + _currentRating;
    _avgRating = _currentTotal / _numRating;
    await updateRating();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Rating Page"),
          elevation: 0,
          actions: <Widget>[],
        ),
        backgroundColor: Colors.blue[50],
        body: Container(
            child: Center(
                child: SingleChildScrollView(
                    child: Column(children: <Widget>[
          bar.RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              _currentRating = rating;
            },
          ),
          SizedBox(height: 15.0),
          RaisedButton(
              color: Colors.blue[400],
              child: Text(
                'Enter',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _onSubmit();
                Navigator.of(context).pop();
              })
        ])))));
  }
}
