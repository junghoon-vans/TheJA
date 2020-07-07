import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:theja/models/models.dart';

final String collectionTable = 'collection';
final String collectionColumnId = 'id';
final String collectionColumnName = 'name';

final String vehicleTable = 'vehicle';
final String vehicleColumnId = 'id';
final String vehicleColumnName = 'name';
final String vehicleColumnStation = 'station';
final String vehicleColumnStationId = 'station_id';
final String vehicleColumnType = 'type';

final String relationTable = 'relation';

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
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $collectionTable(
        $collectionColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $collectionColumnName TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $vehicleTable(
        $vehicleColumnId INTEGER PRIMARY KEY,
        $vehicleColumnName TEXT,
        $vehicleColumnStation TEXT,
        $vehicleColumnStationId INTEGER,
        $vehicleColumnType INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE $relationTable(
        collection_id INTEGER,
        vehicle_id INTEGER,
        FOREIGN KEY(collection_id) REFERENCES $collectionTable(id),
        FOREIGN KEY(vehicle_id) REFERENCES $vehicleTable(id)
      )
    ''');
  }

  Future<Collection> insertCollection(Collection collection) async {
    var db = await database;

    collection.id = await db.insert(collectionTable, collection.toMap());
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

  Future<Vehicle> insertVehicle(Vehicle vehicle) async {
    var db = await database;

    vehicle.id = await db.insert(vehicleTable, vehicle.toMap());
    return vehicle;
  }

  Future<List<Vehicle>> getVehicles(int id) async {
    var db = await database;

    var vehicles = await db
        .query(vehicleTable, columns: [vehicleColumnId, vehicleColumnName]);

    List<Vehicle> vehicleList = List<Vehicle>();
    vehicles.forEach((element) {
      Vehicle vehicle = Vehicle.fromMap(element);
      vehicleList.add(vehicle);
    });

    return vehicleList;
  }

  Future<int> deleteVehicle(int id) async {
    var db = await database;

    return await db.delete(
      vehicleTable,
      where: '$vehicleColumnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateVehicle(Vehicle vehicle) async {
    var db = await database;

    return await db.update(
      vehicleTable,
      vehicle.toMap(),
      where: '$vehicleColumnId = ?',
      whereArgs: [vehicle.id],
    );
  }
}
