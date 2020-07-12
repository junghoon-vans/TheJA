import 'package:theja/utils/db_helper.dart';

class Vehicle {
  int id;
  int routeId;
  String routeName;
  int stationId;
  String station;
  int type;

  Vehicle(
      {this.id,
      this.routeId,
      this.routeName,
      this.station,
      this.stationId,
      this.type});

  Map<String, dynamic> toMap({bool reorder = false}) {
    var map = <String, dynamic>{
      vehicleColumnRouteId: routeId,
      vehicleColumnRouteName: routeName,
      vehicleColumnStationId: stationId,
      vehicleColumnStation: station,
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
    station = map[vehicleColumnStation];
    type = map[vehicleColumnType];
  }

  @override
  String toString() {
    return '$routeName';
  }
}
