import 'package:app_refeicoes/db/database_provider.dart';
import 'package:app_refeicoes/models/ingredient.dart';
import 'package:app_refeicoes/models/meal.dart';
import 'package:app_refeicoes/models/step.dart';
import 'package:sqflite/sqflite.dart';

class RegistrationRepository{
  late final Database _database;

  Future<void> initDb() async{
    _database = await DBProvider.db.database;
  }

  Future<void> insertMeal({String? name, String? cost,String? complexity,String? img,int? duration,String? category,bool? favorite}) async{
    await _database.insert(
      "meal", 
    {
      "name" : name,
      "cost" : cost,
      "complexity" : complexity,
      "img" : img,
      "duration" : duration,
      "category" : category,
      "favorite" : favorite != false ? 1 : 0
    });
  }

  Future<void> insertIngredients(String name) async{
    await _database.insert("ingredient", {"name" : name});
  }

  Future<void> insertStep(String name) async{
    await _database.insert("step",{"name" : name});
  }

  Future<List<Meal>> findAllMeals() async {
    List<Map<String, dynamic>> mealMap = await _database.rawQuery("SELECT * FROM meal");
    
    return Meal.fromMapList(mealMap);
  }



  Future<List<Ingredient>> findAllIngredients() async{
    List<Map<String, dynamic>> ingredientMap = await _database.rawQuery("SELECT * FROM ingredient");
    return Ingredient.fromMapList(ingredientMap);
  }


  Future<List<Step>> findAllSteps() async{
    List<Map<String, dynamic>> stepMap = await _database.rawQuery("SELECT * FROM step");
    return Step.fromMapList(stepMap);
  }
}