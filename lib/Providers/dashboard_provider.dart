import 'package:flutter/cupertino.dart';
import 'package:wantsbro_admin/constants.dart';

class DashboardProvider extends ChangeNotifier {
  Future<double> _totalbyStatus(String status) async {
    return await orderCollection
        .where("orderStatus", isEqualTo: status)
        .get()
        .then((value) {
      final dataList = value.docs;
      double total = 0.0;

      for (var i = 0; i < dataList.length; i++) {
        total += dataList[i].data()["totalCartPrice"];
      }
      return total;
    });
  }

  Future<int> get getAllOrdersNumber async {
    return await orderCollection.get().then((value) => value.docs.length);
  }

  Future<int> get getAllCompletedOrdersNumber async {
    return await orderCollection
        .where("orderStatus", isEqualTo: "Completed")
        .get()
        .then((value) => value.docs.length);
  }

  Future<int> get getAllAwaitingOrdersNumber async {
    return await orderCollection
        .where("orderStatus", isEqualTo: "Awaiting Acceptance")
        .get()
        .then((value) => value.docs.length);
  }

  Future<int> get getAllProcessingOrdersNumber async {
    return await orderCollection
        .where("orderStatus", isEqualTo: "Processing")
        .get()
        .then((value) => value.docs.length);
  }

  Future<double> get getTotalAmountSold async {
    double com = await _totalbyStatus("Completed");
    double ac = await _totalbyStatus("Awaiting Acceptance");
    double pc = await _totalbyStatus("Processing");

    return com + ac + pc;
  }
}
