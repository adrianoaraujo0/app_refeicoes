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
        await db.execute("CREATE TABLE contato(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, nome TEXT, email TEXT, phone TEXT)");
      },
    );    
  }

}