import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theja/blocs/collection/collection.dart';
import 'package:theja/models/models.dart';
import 'package:theja/utils/db_helper.dart';

class CollectionDBHelper {
  CollectionDBHelper._();

  static final CollectionDBHelper db = CollectionDBHelper._();

  insert(BuildContext context, String value) {
    Collection collection = Collection(name: value);

    DBHelper.db.insertCollection(collection).then(
          (storedCollection) => BlocProvider.of<CollectionBloc>(context).add(
            AddCollection(storedCollection),
          ),
        );
  }

  delete(BuildContext context, int id, int index) {
    DBHelper.db.deleteCollection(id).then((_) =>
        BlocProvider.of<CollectionBloc>(context).add(DeleteCollection(index)));
  }

  update(BuildContext context, int index, Collection collection) {
    DBHelper.db.updateCollection(collection).then(
          (storedCollection) => BlocProvider.of<CollectionBloc>(context).add(
            UpdateCollection(index, collection),
          ),
        );
  }
}
