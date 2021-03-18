import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:wantsbro_admin/constants.dart';

class UserProvider extends ChangeNotifier {
  Future<DocumentSnapshot> getUserInfo(String userID) async {
    return await userCollection.doc(userID).get();
  }

  Stream<QuerySnapshot> getAllUsers() {
    return userCollection.snapshots();
  }
}
