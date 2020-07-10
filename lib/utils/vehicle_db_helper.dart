import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theja/blocs/blocs.dart';
import 'package:theja/models/models.dart';
import 'package:theja/utils/db_helper.dart';

class VehicleDBHelper {
  VehicleDBHelper._();

  static final VehicleDBHelper db = VehicleDBHelper._();

  insert(BuildContext context, Vehicle vehicle, int collectionId) {
    DBHelper.db.insertVehicle(vehicle, collectionId).then(
          (isVehicleExist) => isVehicleExist != null
              ? BlocProvider.of<VehicleBloc>(context).add(AddVehicle(vehicle))
              : null,
        );
  }

  delete({BuildContext context, int collectionId, int vehicleId, int index}) {
    DBHelper.db.deleteVehicle(collectionId, vehicleId).then(
        (_) => BlocProvider.of<VehicleBloc>(context).add(DeleteVehicle(index)));
  }
}
