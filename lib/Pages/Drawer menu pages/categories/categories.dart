import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wantsbro_admin/Other%20Pages/loading.dart';
import 'package:wantsbro_admin/Other%20Pages/something_went_wrong.dart';
import 'package:wantsbro_admin/Pages/Drawer%20menu%20pages/categories/edit_categories.dart';
import 'package:wantsbro_admin/Providers/category_provider.dart';
import 'package:wantsbro_admin/models/category_model.dart';
import 'package:wantsbro_admin/theming/color_constants.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  String _parentName;

  @override
  void initState() {
    super.initState();
    _parentName = "";
  }

  @override
  Widget build(BuildContext context) {
    void _addCategory() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditCategory(),
        ),
      );
    }

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _addCategory,
          child: Icon(Icons.add),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(labelText: "Parent Id"),
                  onChanged: (value) {
                    setState(() {
                      _parentName = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream:
                      Provider.of<CategoryProvider>(context).getAllCategories(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return SomethingWentWrong();
                    } else if (!snapshot.hasData) {
                      return Loading();
                    } else {
                      final l = snapshot.data.docs;
                      final dataList = _parentName == ""
                          ? l
                          : l
                              .where((element) => element
                                  .data()["parentID"]
                                  .startsWith(_parentName))
                              .toList();
                      if (dataList.isEmpty) {
                        return Center(
                          child: Text("No Categories"),
                        );
                      }
                      return ListView(
                        children: dataList
                            .map((e) => Card(
                                  color: e.data()["parentID"] == ""
                                      ? Colors.indigo
                                      : mainColor,
                                  child: ListTile(
                                    title: Text(e.data()["name"]),
                                    subtitle: e.data()["parentID"] == ""
                                        ? SelectableText("ID: ${e.id}")
                                        : SelectableText(
                                            "ID: ${e.id}\nParent: ${e.data()["parentID"]}"),
                                    leading: Container(
                                      width: 50,
                                      height: 50,
                                      child:
                                          Image.network(e.data()["imageUrl"]),
                                    ),
                                    isThreeLine: e.data()["parentID"] == ""
                                        ? false
                                        : true,
                                    trailing: IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditCategory(
                                              category: CategoryModel.fromMap(
                                                  e.data()),
                                              categoryId: e.id,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ))
                            .toList(),
                      );
                      // DataCell(
                      //   Text(e.data()["name"]),
                      // ),
                      // DataCell(
                      //   Text(e.id.toString()),
                      // ),
                      // DataCell(
                      //   Text(e.data()["parentID"] == ""
                      //       ? "No parent"
                      //       : e.data()["parentID"]),
                      // ),
                      // DataCell(
                      //   Text(e.data()["imageUrl"]),

                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
