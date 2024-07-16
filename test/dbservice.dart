import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbService {
  final _table = "RecentSearchTable";
  final _columnId = '_id';
  final _columnCityName = 'cityname';
  final _columnDatetime = 'datetime';

  DbService() {
    openMyDatabase();
  }

  Future<Database> openMyDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'my_database.db');

    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_table (
            $_columnId INTEGER PRIMARY KEY,
            $_columnCityName TEXT NOT NULL,
            $_columnDatetime TEXT NOT NULL
          )
        ''');
      },
    );
    print("Database Created Successfully");
    return database;
  }

  Future<void> insertDatainDB(String cityname, String datetime) async {
    final db = await openMyDatabase();
    await db.insert(
      _table,
      {
        _columnCityName: cityname,
        _columnDatetime: datetime,
      },
    );
    print("Inserted Successfully: $cityname and $datetime");
  }

  Future<List<Map<String, dynamic>>> fetchDatefromDB() async {
    print("data fetched");
    final db = await openMyDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_table);
    return maps;
  }
}
