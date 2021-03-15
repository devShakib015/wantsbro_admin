import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wantsbro_admin/Pages/Drawer%20menu%20pages/dashboard.dart';
import 'package:wantsbro_admin/Providers/auth_provider.dart';
import 'package:wantsbro_admin/drawer_menu_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _appBarTitle;

  Widget _body;

  @override
  void initState() {
    super.initState();
    _appBarTitle = drawerMenus.first["title"];

    _body = Dashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            _drawerHeader(),
            _drawerMenu(context),
          ],
        ),
      ),
      body: _body,
    );
  }

  Expanded _drawerMenu(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: drawerMenus
            .map((e) => ListTile(
                  title: Text(e["title"]),
                  leading: e["icon"],
                  onTap: () {
                    setState(() {
                      _appBarTitle = e["title"];
                      _body = e["body"];
                      Navigator.pop(context);
                    });
                  },
                ))
            .toList(),
      ),
    );
  }

  DrawerHeader _drawerHeader() {
    return DrawerHeader(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            child: Image.asset("assets/images/logo/logo.png"),
          ),
          SizedBox(
            height: 10,
          ),
          Text("Welcome Admin"),
          SizedBox(
            height: 5,
          ),
          Text(Provider.of<AuthProvider>(context).currenetUserEmail),
        ],
      ),
    );
  }
}
