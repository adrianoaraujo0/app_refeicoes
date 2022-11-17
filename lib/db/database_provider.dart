import 'package:sqflite/sqflite.dart';
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
      idMeal INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      uidMeal,
      name TEXT,
      cost TEXT,
      complexity TEXT,
      img TEXT,
      duration INTEGER,
      category TEXT,
      mealIngredient TEXT,
      mealStep TEXT,
      glutenFree INTEGER,
      lactoseFree INTEGER,
      vegan INTEGER,
      vegetarian INTEGER,
      favorite INTEGER
    );
  ''';

  String get _ingredient => '''
    CREATE TABLE ingredient(
      idIngredient INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      uidMeal,
      name TEXT
    );
  ''';

  String get _step => '''
    CREATE TABLE step(
      idStep INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      uidMeal,
      name TEXT
    );
  ''';
}