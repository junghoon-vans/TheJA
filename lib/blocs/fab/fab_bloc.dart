import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:theja/blocs/fab/fab.dart';
import 'package:theja/models/models.dart';

class FabBloc extends Bloc<FabEvent, AppFab> {
  @override
  AppFab get initialState => AppFab.normal;

  @override
  Stream<AppFab> mapEventToState(FabEvent event) async* {
    if (event is FabUpdated) {
      yield event.fab;
    }
  }
}
