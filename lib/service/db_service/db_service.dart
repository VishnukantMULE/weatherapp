import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbService{
  final _table ="RecentSearchTable";
  final _columnId='_id';
  final _columncityName='cityname';
  final _columndatetime='datetime';


  DbService(){
    openMyDatabase();
  }
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

  Future<Database> InsertDatainDB(String cityname, String datetime) async {

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'my_database.db');


    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        db.rawInsert(
            'INSERT INTO recent_search ($_columncityName, $_columndatetime) VALUES (?, ?)',
            [cityname, datetime]
        );
      },
    );
    print("Inserted Successfully $cityname and $datetime");
    return database;
  }


  // Future<List<Map<String,dynamic>>> fetchDatefromDB() async{
  //
  //   final dbPath = await getDatabasesPath();
  //   final path = join(dbPath, 'my_database.db');
  //
  //   onCreate: (db, version) async {
  //
  //   }
  //
  //
  //
  // }


}