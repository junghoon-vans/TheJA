import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
}
