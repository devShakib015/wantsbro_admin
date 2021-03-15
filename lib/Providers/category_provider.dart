import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wantsbro_admin/constants.dart';
import 'package:wantsbro_admin/models/category_model.dart';
import 'package:toast/toast.dart';

class CategoryProvider extends ChangeNotifier {
  Stream<QuerySnapshot> getAllCategories() {
    return categoryCollection.orderBy("parentID").snapshots();
  }

  Stream<QuerySnapshot> getCategoryByParent({@required String parentID}) {
    return categoryCollection
        .where("parentID", isEqualTo: parentID)
        .snapshots();
  }

  Future<int> getParentCategoryLength() {
    return categoryCollection
        .where("parentID", isEqualTo: "")
        .snapshots()
        .length;
  }

  Future<void> addNewCategory(
      BuildContext context, CategoryModel categoryModel) async {
    await categoryCollection
        .doc(
            "${categoryModel.name.toLowerCase()}${DateTime.now().millisecondsSinceEpoch}")
        .set(
          categoryModel.toMap(),
        );

    notifyListeners();
    Toast.show("Category is successfully saved", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  Future<void> updateCategory(
      BuildContext context, CategoryModel categoryModel, String id) async {
    await categoryCollection.doc(id).update(
          categoryModel.toMap(),
        );

    notifyListeners();
    Toast.show("Category is successfully Updated", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  Future<void> deleteCategory(BuildContext context, String id) async {
    await categoryCollection.doc(id).delete();

    notifyListeners();
  }
}
