import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theja/blocs/collection/collection.dart';
import 'package:theja/models/models.dart';
import 'package:theja/utils/db_helper.dart';

class CollectionDBHelper {
  CollectionDBHelper._();

  static final CollectionDBHelper db = CollectionDBHelper._();

  insert(context, value) {
    Collection collection = Collection(name: value);

    DBHelper.db.insertCollection(collection).then(
          (storedCollection) => BlocProvider.of<CollectionBloc>(context).add(
            AddCollection(storedCollection),
          ),
        );
  }

  delete(context, id, index) {
    DBHelper.db.deleteCollection(id).then(
          (_) => BlocProvider.of<CollectionBloc>(context)
              .add(DeleteCollection(index)),
        );
  }
}
