import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wantsbro_admin/Providers/dashboard_provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {},
      ),
      body: DashboardBody(),
    );
  }
}

class DashboardBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder<double>(
                future:
                    Provider.of<DashboardProvider>(context).getTotalAmountSold,
                initialData: 0,
                builder:
                    (BuildContext context, AsyncSnapshot<double> snapshot) {
                  return Text(
                    snapshot.data.toString(),
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
