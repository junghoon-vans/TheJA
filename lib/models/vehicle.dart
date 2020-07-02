import 'package:equatable/equatable.dart';

class Vehicle extends Equatable {
  final String name;
  final String description;

  Vehicle(this.name, this.description);

  @override
  List<Object> get props => [name, description];

  @override
  String toString() {
    return '$name';
  }
}
