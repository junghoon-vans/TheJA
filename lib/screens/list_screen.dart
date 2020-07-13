import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theja/blocs/blocs.dart';
import 'package:theja/data.dart';
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
              // showSearch(
              //   context: context,
              //   delegate: VehicleSearch(),
              // );
              VehicleDBHelper.db.insert(
                  context: context,
                  vehicle: vehicle,
                  collectionName: collectionName);
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
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final resultList = [];

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.directions_subway),
        title: Text('${resultList[index]}'),
      ),
      itemCount: resultList.length,
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
