import 'package:theja/models/models.dart';

class Bus extends Vehicle {
  int routeId;
  String routeName;
  int stationId;
  String stationName;
  int type = VehicleType.bus.index;

  Bus({
    this.routeId,
    this.routeName,
    this.stationName,
    this.stationId,
  });
}
