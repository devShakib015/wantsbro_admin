import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wantsbro_admin/Other%20Pages/loading.dart';
import 'package:wantsbro_admin/Other%20Pages/something_went_wrong.dart';
import 'package:wantsbro_admin/Pages/Drawer%20menu%20pages/products/child_category_select.dart';
import 'package:wantsbro_admin/Providers/category_provider.dart';

class ParentCategorySelect extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Parent Category"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Provider.of<CategoryProvider>(context)
            .getCategoryByParent(parentID: ""),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return SomethingWentWrong();
          } else if (!snapshot.hasData) {
            return Loading();
          } else {
            final dataList = snapshot.data.docs;
            if (dataList.isEmpty) {
              return Center(
                child: Text("No Parent Category"),
              );
            }
            return ListView(
              children: dataList
                  .map((e) => Card(
                        color: Colors.indigo,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChildCategorySelect(
                                  parentId: e.id,
                                  parentName: e.data()["name"],
                                ),
                              ),
                            );
                          },
                          title: Text(e.data()["name"]),
                          subtitle: Text("ID: ${e.id}"),
                          leading: Container(
                            width: 50,
                            height: 50,
                            child: Image.network(e.data()["imageUrl"]),
                          ),
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
