import 'package:equatable/equatable.dart';

class Collection extends Equatable {
  final String _name;

  Collection(this._name);

  @override
  List<Object> get props => [_name];

  @override
  String toString() {
    return '$_name';
  }

  String get name => _name;
}
