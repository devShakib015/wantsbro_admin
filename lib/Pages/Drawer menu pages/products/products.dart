import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wantsbro_admin/Other%20Pages/loading.dart';
import 'package:wantsbro_admin/Other%20Pages/something_went_wrong.dart';
import 'package:wantsbro_admin/Pages/Drawer%20menu%20pages/products/edit_single_product.dart';
import 'package:wantsbro_admin/Pages/Drawer%20menu%20pages/products/multiple_products/edit_multiple_product.dart';
import 'package:wantsbro_admin/Pages/Drawer%20menu%20pages/products/parent_category_select.dart';
import 'package:wantsbro_admin/Providers/category_provider.dart';
import 'package:wantsbro_admin/Providers/product_provider.dart';
import 'package:wantsbro_admin/theming/color_constants.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  String _searchValue;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Provider.of<CategoryProvider>(context)
          .getCategoryByParent(parentID: ""),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return SomethingWentWrong();
        } else if (!snapshot.hasData) {
          return Loading();
        } else {
          final dataList = snapshot.data.docs;
          return _topTabBar(dataList, context);
        }
      },
    );
  }

  DefaultTabController _topTabBar(
      List<QueryDocumentSnapshot> dataList, BuildContext context) {
    return DefaultTabController(
      length: dataList.length,
      child: Scaffold(
        appBar: TabBar(
          labelPadding: EdgeInsets.all(16),
          indicatorColor: white,
          unselectedLabelColor: disableWhite,
          isScrollable: true,
          tabs: dataList.map((e) => Text(e.data()["name"])).toList(),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          tooltip: "Add New Product",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ParentCategorySelect(),
              ),
            );
          },
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: TabBarView(
            children: dataList.map(
              (e) {
                return StreamBuilder<QuerySnapshot>(
                  stream: Provider.of<CategoryProvider>(context)
                      .getCategoryByParent(parentID: e.id),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return SomethingWentWrong();
                    } else if (!snapshot.hasData) {
                      return Loading();
                    } else {
                      final childDataList = snapshot.data.docs;
                      return _secondTabBar(childDataList, context);
                    }
                  },
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }

  DefaultTabController _secondTabBar(
      List<QueryDocumentSnapshot> childDataList, BuildContext context) {
    return DefaultTabController(
      length: childDataList.length,
      child: Scaffold(
        appBar: TabBar(
          labelPadding: EdgeInsets.all(16),
          indicatorColor: white,
          unselectedLabelColor: disableWhite,
          isScrollable: true,
          tabs: childDataList
              .map(
                (e) => Text(e.data()["name"]),
              )
              .toList(),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: "Search product by title",
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
                children: childDataList
                    .map(
                      (e) => StreamBuilder<QuerySnapshot>(
                        stream: Provider.of<ProductProvider>(context)
                            .getProductsByChildCategoryID(
                                childCategoryID: e.id),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return SomethingWentWrong();
                          } else if (!snapshot.hasData) {
                            return Loading();
                          } else {
                            String getMultipleProductPrices(
                                var list, String price) {
                              List prices = [];
                              for (var i = 0; i < list.length; i++) {
                                prices.add(list[i][price]);
                              }

                              prices.sort();
                              return "${prices.last} - ${prices.first}";
                            }

                            final l = snapshot.data.docs.toList();
                            final productDataList =
                                _searchValue == "" || _searchValue == null
                                    ? l
                                    : l
                                        .where((element) => element
                                            .data()["title"]
                                            .startsWith(_searchValue))
                                        .toList();
                            if (productDataList.isEmpty) {
                              return Center(
                                child: Text("No Products"),
                              );
                            }
                            return _productListView(productDataList, context,
                                getMultipleProductPrices);
                          }
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView _productListView(
      List<QueryDocumentSnapshot> productDataList,
      BuildContext context,
      String getMultipleProductPrices(dynamic list, String price)) {
    return ListView(
      children: productDataList
          .map((e) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          if (e.data()["isSingle"]) {
                            return Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditSingleProduct(
                                  childId: e.data()["childCategoryID"],
                                  childName: e.data()["childCategoryName"],
                                  id: e.id,
                                  isSingle: e.data()["isSingle"],
                                  parentId: e.data()["parentCategoryID"],
                                  parentName: e.data()["parentCategoryName"],
                                  product: e.data(),
                                ),
                              ),
                            );
                          } else {
                            return Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditMultipleProduct(
                                  attributesList: null,
                                  productVariation:
                                      e.data()["productVariation"],
                                  childId: e.data()["childCategoryID"],
                                  childName: e.data()["childCategoryName"],
                                  id: e.id,
                                  isSingle: e.data()["isSingle"],
                                  parentId: e.data()["parentCategoryID"],
                                  parentName: e.data()["parentCategoryName"],
                                  product: e.data(),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      leading: Container(
                        width: 80,
                        child: Image.network(e.data()["featuredImages"][0]),
                      ),
                      title: Text(e.data()["title"]),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.data()["isSingle"]
                              ? "Single Product"
                              : "Multiple Product"),
                          Text(
                            e.data()["isSingle"]
                                ? "OP: ${e.data()["originalPrice"]} \nSP: ${e.data()["salePrice"]}"
                                : "OP: ${getMultipleProductPrices(e.data()["productVariation"], "originalPrice")} \nSP: ${getMultipleProductPrices(e.data()["productVariation"], "salePrice")}",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
