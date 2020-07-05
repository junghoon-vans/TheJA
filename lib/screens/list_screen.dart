import 'package:flutter/material.dart';
import 'package:theja/widgets/views/vehicle_list_view.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lists"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: VehicleListView(),
    );
  }
}
