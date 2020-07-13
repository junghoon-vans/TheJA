import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theja/blocs/blocs.dart';
import 'package:theja/models/models.dart';
import 'package:theja/utils/db_helper.dart';

class VehicleDBHelper {
  VehicleDBHelper._();

  static final VehicleDBHelper db = VehicleDBHelper._();

  insert({BuildContext context, Vehicle vehicle, String collectionName}) {
    DBHelper.db.insertVehicle(vehicle, collectionName).then(
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
      int routeId}) {
    DBHelper.db.deleteVehicle(collectionName, routeId).then((_) =>
        BlocProvider.of<VehicleBloc>(context).add(DeleteVehicle(widgetIndex)));
  }

  reorder(List<Vehicle> vehicleList) {
    DBHelper.db.reorderVehicles(vehicleList);
  }
}
