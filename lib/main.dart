import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wantsbro_admin/Other%20Pages/loading.dart';
import 'package:wantsbro_admin/Other%20Pages/something_went_wrong.dart';
import 'package:wantsbro_admin/Providers/auth_provider.dart';
import 'package:wantsbro_admin/Providers/category_provider.dart';
import 'package:wantsbro_admin/Providers/product_provider.dart';
import 'package:wantsbro_admin/Providers/storage_provider.dart';
import 'package:wantsbro_admin/landing_page.dart';
import 'package:wantsbro_admin/theming/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(WantsBroAdminApp());
}

class WantsBroAdminApp extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MainApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Loading();
      },
    );
  }
}

//! Check internet connection

Stream<bool> checkInternet() async* {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      yield true;
    }
  } on SocketException catch (_) {
    yield false;
  }
}

//! MainApp

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: checkInternet(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == false) {
          return internetConnectionWidget();
        } else
          return multiProvider();
      },
    );
  }

  //! Providing MultiProvider

  Widget multiProvider() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<StorageProvider>(
          create: (_) => StorageProvider(),
        ),
        ChangeNotifierProvider<CategoryProvider>(
          create: (_) => CategoryProvider(),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (_) => ProductProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'wantsBro',
        debugShowCheckedModeBanner: false,
        theme: mainTheme,
        home: LandingPage(),
      ),
    );
  }

  //! Showing Internet Connection is active or not

  Widget internetConnectionWidget() {
    return MaterialApp(
      theme: mainTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: (Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("No internet connection."),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text("Reload"),
              )
            ],
          ),
        )),
      ),
    );
  }
}