import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wantsbro_admin/Other%20Pages/loading.dart';
import 'package:wantsbro_admin/Other%20Pages/something_went_wrong.dart';
import 'package:wantsbro_admin/Pages/AuthPages/login.dart';
import 'package:wantsbro_admin/Pages/HomePages/home.dart';
import 'package:wantsbro_admin/Providers/auth_provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of<AuthProvider>(context).authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return SomethingWentWrong();
        } else if (!snapshot.hasData) {
          return LoginPage();
        } else {
          return Home();
        }
      },
    );
  }
}
