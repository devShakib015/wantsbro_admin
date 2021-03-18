import 'package:flutter/material.dart';

class ViewUser extends StatelessWidget {
  final Map userDetails;
  const ViewUser({Key key, @required this.userDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dateOfBirth = "${userDetails["dateOfBirth"]?.toDate() ?? "Not Set"}";
    return Scaffold(
      appBar: AppBar(
        title: Text(userDetails["customerId"]),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              child: Image.network(userDetails["dpURL"]),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 20,
              thickness: 2,
            ),
            _profileCard(Icons.person, "${userDetails["name"]}"),
            _profileCard(Icons.email, "${userDetails["email"]}"),
            _profileCard(Icons.date_range,
                "${dateOfBirth == "Not Set" ? "Not Set" : dateOfBirth.substring(0, 10)}"),
            _profileCard(Icons.phone, "${userDetails["phone"] ?? "Not Set"}"),
            _profileCard(
                Icons.person_search, "${userDetails["gender"] ?? "Not Set"}"),
            _profileCard(
                Icons.work, "${userDetails["occupation"] ?? "Not Set"}"),
          ],
        ),
      ),
    );
  }

  Card _profileCard(IconData icon, String title) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
      ),
    );
  }
}
