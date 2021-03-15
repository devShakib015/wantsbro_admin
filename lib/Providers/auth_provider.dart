import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wantsbro_admin/constants.dart';

class AuthProvider extends ChangeNotifier {
  Stream<User> authStateChanges() {
    return firebaseAuth.authStateChanges();
  }

  Future<User> signIn(
      BuildContext context, String email, String password) async {
    try {
      final UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("No user found for that email.")));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Wrong password provided for that user.")));
      }
      return null;
    }
  }

  String get currenetUserEmail {
    if (firebaseAuth.currentUser != null) {
      return firebaseAuth.currentUser.email;
    } else
      return null;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    notifyListeners();
  }
}
