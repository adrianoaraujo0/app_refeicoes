import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database? _database;

  Future<Database> get database async => _database ??= await initDB();

  Future<Database> initDB() async{
    String path = join(await getDatabasesPath(), "meal_list.db");
    return await openDatabase(path, version: 1,
      onCreate: (db, version) async {
        await db.execute(_meal);
        await db.execute(_ingredient);
        await db.execute(_step);
      },
    );    
  }

  String get _meal => '''
    CREATE TABLE meal(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      name TEXT,
      cost TEXT,
      complexity TEXT,
      category TEXT,
      duration REAL,
      imgUrl TEXT
    );
  ''';

  String get _ingredient => '''
    CREATE TABLE ingredient(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      mealId INTEGER,
      name TEXT
    );
  ''';

  String get _step => '''
    CREATE TABLE step(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      mealId INTEGER,
      name TEXT
    );
  ''';
}