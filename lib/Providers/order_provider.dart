import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:wantsbro_admin/constants.dart';

class OrderProvider extends ChangeNotifier {
  Stream<QuerySnapshot> getOrders(String status) {
    if (status == "All Orders") {
      return orderCollection.orderBy("orderTime", descending: true).snapshots();
    } else {
      return orderCollection
          .where("orderStatus", isEqualTo: status)
          .snapshots();
    }
  }

  Future<DocumentSnapshot> getOrderDetails(String orderId) async {
    return await orderCollection.doc(orderId).get();
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    await orderCollection.doc(orderId).update({"orderStatus": status});
    notifyListeners();
  }
}
