import 'package:flutter/material.dart';

class ViewUser extends StatelessWidget {
  final Map userDetails;
  const ViewUser({Key key, @required this.userDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dateOfBirth = "${userDetails["dateOfBirth"]?.toDate() ?? "Not Set"}";
    return Scaffold(
      appBar: AppBar(
        title: Text(userDetails["name"]),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Customer Id: ${userDetails["customerId"]}"),
            Text("Email: ${userDetails["email"]}"),
            Text(
                "Date of Birth: ${dateOfBirth == "Not Set" ? "Not Set" : dateOfBirth.substring(0, 10)}"),
            Text("Phone: ${userDetails["phone"] ?? "Not Set"}"),
            Text("Gender: ${userDetails["gender"] ?? "Not Set"}"),
            Text("Occupation: ${userDetails["occupation"] ?? "Not Set"}"),
          ],
        ),
      )),
    );
  }
}
