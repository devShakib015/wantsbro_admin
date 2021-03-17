import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';
import 'package:wantsbro_admin/constants.dart';
import 'package:wantsbro_admin/models/multiple_product_model.dart';
import 'package:wantsbro_admin/models/single_product_model.dart';

class ProductProvider extends ChangeNotifier {
  Future<void> addNewSingleProduct(
      BuildContext context, SingleProductModel productModel) async {
    await productCollection.add(
      productModel.toMap(),
    );
    notifyListeners();
    Toast.show("Product is successfully saved", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  Stream<QuerySnapshot> getProductsByChildCategoryID(
      {@required String childCategoryID}) {
    return productCollection
        .where("childCategoryID", isEqualTo: childCategoryID)
        .snapshots();
  }

  Future<DocumentSnapshot> getProductById({@required String productId}) {
    return productCollection.doc(productId).get();
  }

  Stream<QuerySnapshot> searchProductsByChildCategoryID(
      {@required String childCategoryID, @required String searchValue}) {
    return productCollection
        .where("childCategoryID", isEqualTo: childCategoryID)
        .where("title", isEqualTo: searchValue)
        .snapshots();
  }

  Future<void> updateSingleProduct(BuildContext context,
      SingleProductModel singleProductModel, String id) async {
    await productCollection.doc(id).update(
          singleProductModel.toMap(),
        );

    notifyListeners();
    Toast.show("Product is successfully Updated", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  Future<void> updateMultipleProduct(BuildContext context,
      MultipleProductModel multipleProductModel, String id) async {
    await productCollection.doc(id).update(
          multipleProductModel.toMap(),
        );

    notifyListeners();
    Toast.show("Product is successfully Updated", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  Future<void> addNewMultipleProduct(
      BuildContext context, MultipleProductModel productModel) async {
    await productCollection.add(
      productModel.toMap(),
    );
    notifyListeners();
    Toast.show("Product is successfully saved", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  Future<void> deleteProduct(BuildContext context, String id) async {
    await productCollection.doc(id).delete();

    notifyListeners();
  }
}
