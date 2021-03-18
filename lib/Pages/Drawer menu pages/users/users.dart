import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wantsbro_admin/Pages/Drawer%20menu%20pages/users/view_user.dart';
import 'package:wantsbro_admin/Providers/user_provider.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  String _searchValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: StreamBuilder<QuerySnapshot>(
        stream: Provider.of<UserProvider>(context).getAllUsers(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error!"),
            );
          } else {
            final a = snapshot.data.docs.toList();

            final allUsers = _searchValue == "" || _searchValue == null
                ? a
                : a
                    .where((element) =>
                        element.data()["customerId"].startsWith(_searchValue))
                    .toList();

            return Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchValue = value;
                        });
                      },
                      decoration:
                          InputDecoration(labelText: "Search By customerId"),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: allUsers.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewUser(
                                userDetails: allUsers[index].data(),
                              ),
                            ),
                          );
                        },
                        child: Card(
                          child: ListTile(
                            leading:
                                Image.network(allUsers[index].data()["dpURL"]),
                            title: Text(allUsers[index].data()["name"]),
                            subtitle:
                                Text(allUsers[index].data()["customerId"]),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
