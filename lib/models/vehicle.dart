import 'package:equatable/equatable.dart';

class Vehicle extends Equatable {
  final int _type;
  final int _id;
  final String _name;
  final String _station;
  final int _stationId;

  Vehicle(this._type, this._id, this._name, this._station, this._stationId);

  @override
  List<Object> get props => [_type, _id, _name, _station, _stationId];

  @override
  String toString() {
    return '$_name';
  }

  int get type => _type;
  int get id => _id;
  String get name => _name;
  String get station => _station;
  int get stationId => _stationId;
}
