import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wantsbro_admin/Other%20Pages/loading.dart';
import 'package:wantsbro_admin/Other%20Pages/something_went_wrong.dart';
import 'package:wantsbro_admin/Pages/Drawer%20menu%20pages/orders/edit_order.dart';
import 'package:wantsbro_admin/Providers/order_provider.dart';
import 'package:wantsbro_admin/theming/color_constants.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  String _searchValue;
  @override
  Widget build(BuildContext context) {
    List _tabs = [
      "All Orders",
      "Awaiting Acceptance",
      "Processing",
      "Completed",
      "Cancelled",
    ];
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: TabBar(
            labelPadding: EdgeInsets.all(12),
            indicatorColor: white,
            unselectedLabelColor: disableWhite,
            isScrollable: true,
            tabs: _tabs.map((e) => Text(e)).toList()),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: "Search By OrderID",
                  ),
                  onChanged: (v) {
                    setState(() {
                      _searchValue = v;
                    });
                  },
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: _tabs.map(
                    (e) {
                      return StreamBuilder<QuerySnapshot>(
                        stream: Provider.of<OrderProvider>(context)
                            .getOrders(e.toString()),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return SomethingWentWrong();
                          } else if (!snapshot.hasData) {
                            return Loading();
                          } else {
                            final l = snapshot.data.docs.toList();
                            final childDataList =
                                _searchValue == "" || _searchValue == null
                                    ? l
                                    : l
                                        .where((element) => element
                                            .data()["orderId"]
                                            .startsWith(_searchValue))
                                        .toList();

                            if (childDataList.isEmpty) {
                              return Center(
                                child: Text("No Orders"),
                              );
                            } else
                              return Container(
                                child: ListView.builder(
                                  itemCount: childDataList.length,
                                  itemBuilder: (context, index) {
                                    final _value = childDataList[index].data();
                                    final _valueID = childDataList[index].id;

                                    DateTime _time =
                                        _value["orderTime"].toDate();

                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditOrder(
                                              orderID: _valueID,
                                              status: _value["orderStatus"],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Card(
                                        color: _value["orderStatus"] ==
                                                "Awaiting Acceptance"
                                            ? Colors.blueGrey
                                            : (_value["orderStatus"] ==
                                                    "Processing"
                                                ? Colors.lightBlue
                                                : (_value["orderStatus"] ==
                                                        "Cancelled"
                                                    ? mainColor
                                                    : Colors.teal)),
                                        child: ListTile(
                                          leading: Text(
                                              "${childDataList.length - index}."),
                                          title: Text(_value["orderId"]),
                                          trailing: Text(
                                              _value["totalCartPrice"]
                                                  .toString()),
                                          subtitle: Text(
                                            "${_time.year}-${_time.month}-${_time.day}  ${_time.hour}:${_time.minute}:${_time.second}\nStatus: ${_value["orderStatus"]}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                          }
                        },
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
