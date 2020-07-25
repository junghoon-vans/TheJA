import 'package:theja/utils/db_helper.dart';

class Vehicle {
  int id;
  int routeId;
  String routeName;
  int stationId;
  String stationName;
  int type;

  Vehicle(
      {this.id,
      this.routeId,
      this.routeName,
      this.stationName,
      this.stationId,
      this.type});

  @override
  String toString() {
    return '$routeName';
  }

  Map<String, dynamic> toMap({bool reorder = false}) {
    var map = <String, dynamic>{
      vehicleColumnRouteId: routeId,
      vehicleColumnRouteName: routeName,
      vehicleColumnStationId: stationId,
      vehicleColumnStationName: stationName,
      vehicleColumnType: type,
    };

    if (id != null && !reorder) {
      map[vehicleColumnId] = id;
    }

    return map;
  }

  Vehicle.fromMap(Map<String, dynamic> map) {
    id = map[vehicleColumnId];
    routeId = map[vehicleColumnRouteId];
    routeName = map[vehicleColumnRouteName];
    stationId = map[vehicleColumnStationId];
    stationName = map[vehicleColumnStationName];
    type = map[vehicleColumnType];
  }
}
