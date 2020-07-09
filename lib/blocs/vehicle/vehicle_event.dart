import 'package:theja/models/vehicle.dart';

abstract class VehicleEvent {}

class GetVehicles extends VehicleEvent {
  List<Vehicle> vehicleList;

  GetVehicles(List<Vehicle> vehicles) {
    vehicleList = vehicles;
  }
}

class AddVehicle extends VehicleEvent {
  Vehicle newVehicle;

  AddVehicle(Vehicle vehicle) {
    newVehicle = vehicle;
  }
}

class DeleteVehicle extends VehicleEvent {
  int vehicleIndex;

  DeleteVehicle(int index) {
    vehicleIndex = index;
  }
}
