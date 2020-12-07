import 'package:flutter/material.dart';
import 'package:theja/models/models.dart';
import 'package:theja/utils/bus_info_parser.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Arguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Vehicle"),
      ),
      body: FutureBuilder<List<Vehicle>>(
        future: BusInfoParser.bus.searchVehicle(args.stationId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Vehicle> vehicleList = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) => ListTile(
                leading: Icon(
                  _icon(vehicleList[index].type),
                  color: Colors.grey,
                  size: 24.0,
                ),
                title: Text('${vehicleList[index].routeName}'),
                onTap: () {
                  Navigator.pop(context, vehicleList[index]);
                },
              ),
              itemCount: vehicleList.length,
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
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
}
