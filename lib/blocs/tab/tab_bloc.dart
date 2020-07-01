import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:theja/blocs/blocs.dart';
import 'package:theja/models/models.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  @override
  AppTab get initialState => AppTab.home;

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is TabUpdated) {
      yield event.tab;
    }
  }
}
