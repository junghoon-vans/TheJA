import 'package:theja/utils/db_helper.dart';

class Vehicle {
  int id;
  String name;
  String station;
  int stationId;
  int type;

  Vehicle(this.id, this.name, this.station, this.stationId, this.type);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      vehicleColumnName: name,
      vehicleColumnStation: station,
      vehicleColumnStationId: stationId,
      vehicleColumnType: type,
    };

    if (id != null) {
      map[vehicleColumnId] = id;
    }

    return map;
  }

  Vehicle.fromMap(Map<String, dynamic> map) {
    id = map[vehicleColumnId];
    name = map[vehicleColumnName];
    station = map[vehicleColumnStation];
    stationId = map[vehicleColumnStationId];
    type = map[vehicleColumnType];
  }

  @override
  String toString() {
    return '$name';
  }
}
