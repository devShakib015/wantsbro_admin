import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseStorage firebaseStorage = FirebaseStorage.instance;
CollectionReference categoryCollection =
    FirebaseFirestore.instance.collection("categories");
CollectionReference productCollection =
    FirebaseFirestore.instance.collection("products");
CollectionReference orderCollection =
    FirebaseFirestore.instance.collection("orders");
CollectionReference userCollection =
    FirebaseFirestore.instance.collection("users");
