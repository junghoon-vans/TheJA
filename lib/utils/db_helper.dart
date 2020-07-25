import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:theja/models/models.dart';

final String collectionTable = 'collection';
final String collectionColumnId = 'id';
final String collectionColumnName = 'name';

final String vehicleTable = 'vehicle';
final String vehicleColumnId = 'id';
final String vehicleColumnRouteId = 'route_id';
final String vehicleColumnRouteName = 'route_name';
final String vehicleColumnStationId = 'station_id';
final String vehicleColumnStationName = 'station';
final String vehicleColumnType = 'type';

final String relationTable = 'relation';

final String tempTable = 'temp';

class DBHelper {
  DBHelper._();
  static final DBHelper db = DBHelper._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

  Future<Database> initDb() async {
    var dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'sqlite.db'),
      version: 1,
      onConfigure: _onConfigure,
      onCreate: _onCreate,
    );
  }

  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $collectionTable(
        $collectionColumnId INTEGER,
        $collectionColumnName TEXT PRIMARY KEY
      )
    ''');

    await db.execute('''
      CREATE TABLE $vehicleTable(
        $vehicleColumnId INTEGER,
        $vehicleColumnRouteId INTEGER,
        $vehicleColumnRouteName TEXT,
        $vehicleColumnStationId INTEGER,
        $vehicleColumnStationName TEXT,
        $vehicleColumnType INTEGER,
        PRIMARY KEY($vehicleColumnRouteId, $vehicleColumnStationId)
      )
    ''');

    await db.execute('''
      CREATE TABLE $relationTable(
        collection_name TEXT,
        vehicle_route_id INTEGER,
        vehicle_station_id INTEGER,
        FOREIGN KEY(collection_name) REFERENCES $collectionTable(name) ON DELETE CASCADE,
        FOREIGN KEY(vehicle_route_id, vehicle_station_id) REFERENCES $vehicleTable(route_id, station_id)
      )
    ''');
  }

  Future<Collection> insertCollection(Collection collection) async {
    var db = await database;

    String collectionName = collection.name;
    collection.id = await db.rawInsert("""
      INSERT INTO $collectionTable (id, name)
      VALUES((SELECT IFNULL(MAX(id), 0) + 1 FROM $collectionTable), '$collectionName')
    """);
    return collection;
  }

  Future<List<Collection>> getCollections() async {
    var db = await database;

    var collections = await db.query(collectionTable,
        columns: [collectionColumnId, collectionColumnName]);

    List<Collection> collectionList = List<Collection>();
    collections.forEach((element) {
      Collection collection = Collection.fromMap(element);
      collectionList.add(collection);
    });

    return collectionList;
  }

  Future<int> deleteCollection(int id) async {
    var db = await database;

    return await db.delete(
      collectionTable,
      where: '$collectionColumnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateCollection(Collection collection) async {
    var db = await database;

    return await db.update(
      collectionTable,
      collection.toMap(),
      where: '$collectionColumnId = ?',
      whereArgs: [collection.id],
    );
  }

  void reorderCollections(List<Collection> collectionList) async {
    var db = await database;

    await db.execute('''
      CREATE TABLE $tempTable(
        $collectionColumnId INTEGER,
        $collectionColumnName TEXT PRIMARY KEY
      )
    ''');

    collectionList.forEach((collection) {
      db.insert(tempTable, collection.toMap(reorder: true));
    });

    await db.execute('DROP TABLE $collectionTable');
    await db.execute('ALTER TABLE $tempTable RENAME TO $collectionTable');
  }

  Future<int> insertVehicle(String collectionName, Vehicle vehicle) async {
    var db = await database;

    int vehicleRouteId = vehicle.routeId;
    int vehicleStationId = vehicle.stationId;

    List<dynamic> vehicleValueList = vehicle.toMap().values.toList();

    await db.rawInsert('''
      INSERT INTO $vehicleTable (id, route_id, route_name, station_id, station, type)
      SELECT (SELECT IFNULL(MAX(id), 0) + 1 FROM $vehicleTable), ?, ?, ?, ?, ? 
      WHERE NOT EXISTS(
        SELECT 1 FROM $vehicleTable 
        WHERE $vehicleColumnRouteId == $vehicleRouteId
        AND $vehicleColumnStationId == $vehicleStationId
      );
    ''', vehicleValueList);

    int isVehicleExist = await db.rawInsert('''
      INSERT INTO $relationTable (collection_name, vehicle_route_id, vehicle_station_id)
      SELECT '$collectionName', $vehicleRouteId, $vehicleStationId
      WHERE NOT EXISTS(
        SELECT 1 FROM $relationTable 
        WHERE collection_name = '$collectionName'
        AND vehicle_route_id = $vehicleRouteId
        AND vehicle_station_id = $vehicleStationId
      );
    ''');

    return isVehicleExist;
  }

  Future<List<Vehicle>> getVehicles(String collectionName) async {
    var db = await database;

    var vehicles = await db.rawQuery('''
      SELECT * FROM $vehicleTable JOIN $relationTable
      ON $vehicleTable.route_id == $relationTable.vehicle_route_id
      WHERE $relationTable.collection_name == '$collectionName'
      ORDER BY $vehicleColumnId ASC;
    ''');

    List<Vehicle> vehicleList = List<Vehicle>();
    vehicles.forEach((element) {
      Vehicle vehicle = Vehicle.fromMap(element);
      vehicleList.add(vehicle);
    });

    return vehicleList;
  }

  Future<int> deleteVehicle(
      String collectionName, int vehicleRouteId, int vehicleStationId) async {
    var db = await database;

    return await db.delete(
      relationTable,
      where:
          'collection_name = ? AND vehicle_route_id = ? AND vehicle_station_id = ?',
      whereArgs: [collectionName, vehicleRouteId, vehicleStationId],
    );
  }

  void reorderVehicles(List<Vehicle> vehicleList) async {
    var db = await database;

    await db.execute('''
      CREATE TABLE $tempTable(
        $vehicleColumnId INTEGER,
        $vehicleColumnRouteId INTEGER,
        $vehicleColumnRouteName TEXT,
        $vehicleColumnStationId INTEGER,
        $vehicleColumnStationName TEXT,
        $vehicleColumnType INTEGER,
        PRIMARY KEY($vehicleColumnRouteId, $vehicleColumnStationId)
      )
    ''');

    vehicleList.forEach((vehicle) {
      db.insert(tempTable, vehicle.toMap(reorder: true));
    });

    await db.execute('DROP TABLE $vehicleTable');
    await db.execute('ALTER TABLE $tempTable RENAME TO $vehicleTable');
  }
}
