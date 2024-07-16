import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbService{
  final _table ="RecentSearchTable";
  final _columnId='_id';
  final _columncityName='cityname';
  final _columndatetime='datetime';



  Future<Database> openMyDatabase() async {

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'my_database.db');


    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        db.execute(''' 
      CREATE TABLE $_table(
      $_columnId INTEGER PRIMARY KEY,
      $_columncityName TEXT NOT NULL,
      $_columndatetime TEXT NOT NULL
      
      )
      ''');
      },
    );
    print("Database Created Successfully");
    return database;
  }

  Future<void> insertDataInDB(String cityname, String datetime) async {

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'my_database.db');
    final db=await openDatabase(path);
    await db.insert(_table, {
      _columncityName:cityname,
      _columndatetime:datetime,
    },);
    print("Inserted Successfully: $cityname and $datetime");

    final List<Map<String, dynamic>> checkData = await db.query(_table);
    print("Data after insertion: $checkData");

  }


  Future<List<Map<String, dynamic>>> fetchDatafromDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'my_database.db');
    final db = await openDatabase(path);
    // final tables = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");

    final List<Map<String, dynamic>> maps = await db.query(_table);


    return maps;
  }


}