import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wantsbro_admin/Other%20Pages/loading.dart';
import 'package:wantsbro_admin/Other%20Pages/something_went_wrong.dart';
import 'package:wantsbro_admin/Pages/Drawer%20menu%20pages/products/edit_single_product.dart';
import 'package:wantsbro_admin/Pages/Drawer%20menu%20pages/products/multiple_products/attrributes.dart';
import 'package:wantsbro_admin/Providers/category_provider.dart';
import 'package:wantsbro_admin/theming/color_constants.dart';

class ChildCategorySelect extends StatelessWidget {
  final String parentId;
  final String parentName;

  const ChildCategorySelect({
    Key key,
    this.parentId,
    this.parentName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Child Category"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Provider.of<CategoryProvider>(context)
            .getCategoryByParent(parentID: parentId),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return SomethingWentWrong();
          } else if (!snapshot.hasData) {
            return Loading();
          } else {
            final dataList = snapshot.data.docs;
            if (dataList.isEmpty) {
              return Center(
                child: Text("No Child Category"),
              );
            }
            return ListView(
              children: dataList
                  .map((e) => Card(
                        color: mainColor,
                        child: ListTile(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                child: Container(
                                  padding: EdgeInsets.all(24),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditSingleProduct(
                                                  parentId: parentId,
                                                  parentName: parentName,
                                                  childId: e.id,
                                                  childName: e.data()["name"],
                                                  isSingle: true,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text('Single Product')),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Attributes(
                                                  parentId: parentId,
                                                  parentName: parentName,
                                                  childId: e.id,
                                                  childName: e.data()["name"],
                                                  isSingle: false,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text("Multiple Product"))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          title: Text(e.data()["name"]),
                          subtitle: Text(
                              "ID: ${e.id}\nParent: ${e.data()["parentID"]}"),
                          leading: Container(
                            width: 50,
                            height: 50,
                            child: Image.network(e.data()["imageUrl"]),
                          ),
                          isThreeLine: true,
                        ),
                      ))
                  .toList(),
            );
          }
        },
      ),
    );
  }
}
