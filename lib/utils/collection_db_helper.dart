import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theja/blocs/collection/collection.dart';
import 'package:theja/models/models.dart';
import 'package:theja/utils/db_helper.dart';

class CollectionDBHelper {
  CollectionDBHelper._();

  static final CollectionDBHelper db = CollectionDBHelper._();

  insert({BuildContext context, String collectionName}) {
    Collection collection = Collection(name: collectionName);

    DBHelper.db.insertCollection(collection).then(
          (storedCollection) => BlocProvider.of<CollectionBloc>(context).add(
            AddCollection(storedCollection),
          ),
        );
  }

  Future<List<Collection>> get() {
    return DBHelper.db.getCollections();
  }

  delete({BuildContext context, int widgetIndex, int collectionId}) {
    DBHelper.db.deleteCollection(collectionId).then((_) =>
        BlocProvider.of<CollectionBloc>(context)
            .add(DeleteCollection(widgetIndex)));
  }

  update({BuildContext context, int widgetIndex, Collection collection}) {
    DBHelper.db.updateCollection(collection).then(
          (_) => BlocProvider.of<CollectionBloc>(context).add(
            UpdateCollection(widgetIndex, collection),
          ),
        );
  }

  reorder(List<Collection> collectionList) {
    DBHelper.db.reorderCollections(collectionList);
  }
}
