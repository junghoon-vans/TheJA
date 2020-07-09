import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theja/blocs/blocs.dart';
import 'package:theja/models/vehicle.dart';

class VehicleBloc extends Bloc<VehicleEvent, List<Vehicle>> {
  @override
  List<Vehicle> get initialState => List<Vehicle>();

  @override
  Stream<List<Vehicle>> mapEventToState(VehicleEvent event) async* {
    if (event is GetVehicles) {
      yield event.vehicleList;
    } else if (event is AddVehicle) {
      List<Vehicle> newState = List.from(state);
      if (event.newVehicle != null) {
        newState.add(event.newVehicle);
      }
      yield newState;
    } else if (event is DeleteVehicle) {
      List<Vehicle> newState = List.from(state);
      newState.removeAt(event.vehicleIndex);
      yield newState;
    }
  }
}
