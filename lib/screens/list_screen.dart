import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theja/blocs/blocs.dart';
import 'package:theja/models/models.dart';
import 'package:theja/utils/bus_info_parser.dart';
import 'package:theja/utils/vehicle_db_helper.dart';
import 'package:theja/views/views.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String collectionName = ModalRoute.of(context).settings.arguments;

    VehicleDBHelper.db.get(collectionName).then(
          (vehicleList) => BlocProvider.of<VehicleBloc>(context).add(
            GetVehicles(vehicleList),
          ),
        );

    return Scaffold(
      appBar: AppBar(
        title: Text("Lists"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: VehicleSearch(),
              );
            },
          ),
        ],
      ),
      body: VehicleListView(),
    );
  }
}

class VehicleSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {},
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Vehicle>>(
      future: BusInfoParser.bus.searchStation(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Vehicle> stationList = snapshot.data;
          return ListView.builder(
            itemBuilder: (context, index) => ListTile(
              leading: Icon(
                _icon(stationList[index].type),
                color: Colors.grey,
                size: 24.0,
              ),
              title: Text('${stationList[index].stationName}'),
            ),
            itemCount: stationList.length,
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = [];

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.directions_subway),
        title: Text('${suggestionList[index]}'),
      ),
      itemCount: suggestionList.length,
    );
  }
}

_icon(int type) {
  switch (VehicleType.values[type]) {
    case VehicleType.bus:
      return Icons.directions_bus;
    case VehicleType.train:
      return Icons.directions_subway;
    case VehicleType.walk:
      return Icons.directions_walk;
  }
}
