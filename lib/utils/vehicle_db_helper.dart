import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theja/blocs/blocs.dart';
import 'package:theja/models/models.dart';
import 'package:theja/utils/db_helper.dart';

class VehicleDBHelper {
  VehicleDBHelper._();

  static final VehicleDBHelper db = VehicleDBHelper._();

  insert({BuildContext context, String collectionName, Vehicle vehicle}) {
    DBHelper.db.insertVehicle(collectionName, vehicle).then(
          (isVehicleExist) => isVehicleExist != null
              ? BlocProvider.of<VehicleBloc>(context).add(AddVehicle(vehicle))
              : null,
        );
  }

  Future<List<Vehicle>> get(String collectionName) {
    return DBHelper.db.getVehicles(collectionName);
  }

  delete(
      {BuildContext context,
      int widgetIndex,
      String collectionName,
      int routeId,
      int stationId}) {
    DBHelper.db.deleteVehicle(collectionName, routeId, stationId).then((_) =>
        BlocProvider.of<VehicleBloc>(context).add(DeleteVehicle(widgetIndex)));
  }

  reorder(List<Vehicle> vehicleList) {
    DBHelper.db.reorderVehicles(vehicleList);
  }
}
