import 'package:theja/utils/db_helper.dart';

class Collection {
  int id;
  String name;

  Collection({this.id, this.name});

  Map<String, dynamic> toMap({bool reorder = false}) {
    var map = <String, dynamic>{
      collectionColumnName: name,
    };

    if (id != null && !reorder) {
      map[collectionColumnId] = id;
    }

    return map;
  }

  Collection.fromMap(Map<String, dynamic> map) {
    id = map[collectionColumnId];
    name = map[collectionColumnName];
  }

  String toString() {
    return '$name';
  }
}
