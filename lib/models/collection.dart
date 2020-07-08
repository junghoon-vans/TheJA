import 'package:theja/utils/db_helper.dart';

class Collection {
  int id;
  String name;

  Collection({this.id, this.name});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      collectionColumnName: name,
    };

    if (id != null) {
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
