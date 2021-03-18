import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wantsbro_admin/Providers/order_provider.dart';
import 'package:wantsbro_admin/Providers/product_provider.dart';
import 'package:wantsbro_admin/Providers/user_provider.dart';
import 'package:wantsbro_admin/theming/color_constants.dart';

class EditOrder extends StatefulWidget {
  final String orderID;
  final String status;

  const EditOrder({
    Key key,
    @required this.orderID,
    @required this.status,
  }) : super(key: key);
  @override
  _EditOrderState createState() => _EditOrderState();
}

class _EditOrderState extends State<EditOrder> {
  @override
  void initState() {
    super.initState();
    dropdownValue = widget.status;
  }

  List<String> statuses = [
    'Awaiting Acceptance',
    'Processing',
    'Completed',
    //"Cancelled"
  ];
  String dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.orderID),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("STATUS:"),
                  SizedBox(
                    width: 10,
                  ),
                  widget.status == "Cancelled"
                      ? Text("Cancelled")
                      : DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          onChanged: (String newValue) async {
                            setState(() {
                              dropdownValue = newValue;
                            });
                            await Provider.of<OrderProvider>(context,
                                    listen: false)
                                .updateOrderStatus(widget.orderID, newValue);
                          },
                          items: statuses
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                ],
              ),
              FutureBuilder<DocumentSnapshot>(
                future: Provider.of<OrderProvider>(context)
                    .getOrderDetails(widget.orderID),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error!!!'),
                    );
                  } else {
                    final data = snapshot.data;
                    final List cartItems = data["cartItems"];
                    return Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(16),
                            child: FutureBuilder<DocumentSnapshot>(
                              future: Provider.of<UserProvider>(context)
                                  .getUserInfo(data["userId"]),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text("Loading..."),
                                  );
                                } else if (snapshot.hasError) {
                                  return Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text("Error..."),
                                  );
                                } else {
                                  final userData = snapshot.data.data();
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Name: ${userData["name"]}"),
                                      Text(
                                          "CustomerID: ${userData["customerId"]}"),
                                      Text("Email: ${userData["email"]}"),
                                      Text(
                                          "Phone: ${userData["phone"] ?? "Not Set"}"),
                                    ],
                                  );
                                }
                                ;
                              },
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(width: 2, color: mainColor),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          Container(
                              padding: EdgeInsets.all(16),
                              width: double.infinity,
                              child: Text(
                                "Total Price: ${data["totalCartPrice"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          Column(
                            children: [
                              for (var i = 0; i < cartItems.length; i++)
                                Card(
                                  child: FutureBuilder<DocumentSnapshot>(
                                    future:
                                        Provider.of<ProductProvider>(context)
                                            .getProductById(
                                                productId: cartItems[i]
                                                    ["productID"]),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<DocumentSnapshot>
                                            snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                            child: Text("Loading..."));
                                      } else if (snapshot.hasError) {
                                        return Text("There is an error");
                                      } else {
                                        final productData =
                                            snapshot.data.data();

                                        //return Text(cartItems.toString());

                                        return _singleProductCardCart(
                                            context, productData, cartItems[i]);
                                      }
                                    },
                                  ),
                                )
                            ],
                          ),
                          addressCard(
                              addressType: data["shippingAddress"]
                                  ["addressType"],
                              opacity: 0.0,
                              name: data["shippingAddress"]["name"],
                              address: data["shippingAddress"]["address"],
                              area: data["shippingAddress"]["area"],
                              district: data["shippingAddress"]["district"],
                              phone: data["shippingAddress"]["phone"],
                              postCode: data["shippingAddress"]["postCode"],
                              onPressed: null),
                          ElevatedButton(
                              onPressed: () {}, child: Text("Generate Invoice"))
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _singleProductCardCart(BuildContext context,
      Map<String, dynamic> productData, Map<String, dynamic> item) {
    final String _productTitle = item["isSingle"]
        ? productData["title"]
        : "${productData["title"]} (${getAttributes(productData["productVariation"][item["variationIndex"]])})";

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 60,
            height: 60,
            child: Image.network(
              item["isSingle"]
                  ? productData["featuredImages"][0]
                  : productData["productVariation"][item["variationIndex"]]
                      ["variationImageUrl"],
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: SelectableText(
          _productTitle,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Text(item["totalPrice"].toString()),
        subtitle: Text(
          "${productData["parentCategoryName"]}/${productData["childCategoryName"]}\nCount: ${item["count"]}",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  String getAttributes(var data) {
    if (data["attributes"].keys.toList()[0] == "color" ||
        data["attributes"].keys.toList()[1] == "color") {
      if (data["attributes"].keys.toList()[0] == "color") {
        return "${data["attributes"].keys.toList()[1]} : ${data["attributes"]["${data["attributes"].keys.toList()[1]}"]}";
      } else {
        return "${data["attributes"].keys.toList()[0]} : ${data["attributes"]["${data["attributes"].keys.toList()[0]}"]}";
      }
    } else {
      return "${data["attributes"].keys.toList()[0]} : ${data["attributes"]["${data["attributes"].keys.toList()[0]}"]} - ${data["attributes"].keys.toList()[1]} : ${data["attributes"]["${data["attributes"].keys.toList()[1]}"]}";
    }
  }

  Widget addressCard(
      {String addressType,
      String name,
      String phone,
      String address,
      String postCode,
      String area,
      String district,
      double opacity,
      Function onPressed}) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.location_on),
            trailing: Opacity(
              opacity: opacity,
              child: IconButton(
                icon: Icon(Icons.edit),
                onPressed: onPressed,
              ),
            ),
            title: Text(
              addressType,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  phone,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("$address, $area, $district-$postCode"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
