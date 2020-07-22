import 'package:theja/models/models.dart';

abstract class CollectionEvent {}

class GetCollections extends CollectionEvent {
  List<Collection> collectionList;

  GetCollections(List<Collection> collections) {
    collectionList = collections;
  }
}

class AddCollection extends CollectionEvent {
  Collection newCollection;

  AddCollection(Collection collection) {
    newCollection = collection;
  }
}

class DeleteCollection extends CollectionEvent {
  int collectionIndex;

  DeleteCollection(int index) {
    collectionIndex = index;
  }
}

class UpdateCollection extends CollectionEvent {
  Collection newCollection;
  int collectionIndex;

  UpdateCollection(int index, Collection collection) {
    newCollection = collection;
    collectionIndex = index;
  }
}
