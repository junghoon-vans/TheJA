import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theja/blocs/collection/collection.dart';
import 'package:theja/models/collection.dart';

class CollectionBloc extends Bloc<CollectionEvent, List<Collection>> {
  @override
  List<Collection> get initialState => List<Collection>();

  @override
  Stream<List<Collection>> mapEventToState(CollectionEvent event) async* {
    if (event is GetCollections) {
      yield event.collectionList;
    } else if (event is AddCollection) {
      List<Collection> newState = List.from(state);
      if (event.newCollection != null) {
        newState.add(event.newCollection);
      }
      yield newState;
    } else if (event is DeleteCollection) {
      List<Collection> newState = List.from(state);
      newState.removeAt(event.collectionIndex);
      yield newState;
    } else if (event is UpdateCollection) {
      List<Collection> newState = List.from(state);
      newState[event.collectionIndex] = event.newCollection;
      yield newState;
    }
  }
}
