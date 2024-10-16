import 'package:ready_set_cook/models/user.dart' as u;
import 'package:firebase_auth/firebase_auth.dart' as fire;
import 'package:ready_set_cook/services/recipes_database.dart';

class AuthService {
  final fire.FirebaseAuth _auth = fire.FirebaseAuth.instance;

  // create user obj based on firebase user
  u.User _userFromFirebaseUser(fire.User user) {
    return user != null ? u.User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<u.User> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  String getCurrentUserEmail() {
    return _auth.currentUser.email;
  }

  String getCurrentUserdiaplayName() {
    return _auth.currentUser.displayName;
  }

  String getCurrentUserPhotoURL() {
    return _auth.currentUser.photoURL;
  }

  Future<void> updateUserProfile(String displayName, String photoURL) async {
    await _auth.currentUser
        .updateProfile(displayName: displayName, photoURL: photoURL);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      fire.UserCredential result = await _auth.signInAnonymously();
      fire.User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      fire.UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      fire.User user = result.user;
      return user;
    } catch (error) {
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      fire.UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      fire.User user = result.user;

      RecipesDatabaseService(uid: user.uid).addRecipe("1");
      RecipesDatabaseService(uid: user.uid).addRecipe("2");
      RecipesDatabaseService(uid: user.uid).addRecipe("3");
      RecipesDatabaseService(uid: user.uid).addRecipe("4");
      RecipesDatabaseService(uid: user.uid).addRecipe("5");
      RecipesDatabaseService(uid: user.uid).addRecipe("6");
      RecipesDatabaseService(uid: user.uid).addRecipe("7");
      RecipesDatabaseService(uid: user.uid).addRecipe("8");
      RecipesDatabaseService(uid: user.uid).addRecipe("9");

      return _userFromFirebaseUser(user);
    } catch (error) {
      return null;
    }
  }

  // send password reset email
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      return null;
    }
  }
}
