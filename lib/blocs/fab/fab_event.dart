import 'package:equatable/equatable.dart';
import 'package:theja/models/models.dart';

abstract class FabEvent extends Equatable {
  const FabEvent();
}

class FabUpdated extends FabEvent {
  final AppFab fab;

  const FabUpdated(this.fab);

  @override
  List<Object> get props => [fab];

  @override
  String toString() => 'FabUpdated { fab: $fab }';
}
