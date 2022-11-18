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

  Future<void> insertMeal(String name, String uidMeal, String cost, String complexity, String img, int duration, String category,  bool glutenFree, bool lactoseFree, bool vegan, bool vegetarian, bool favorite) async{
    await _database.insert(
      "meal", 
    {
      "uidMeal" : uidMeal,
      "name" : name,
      "cost" : cost,
      "complexity" : complexity,
      "img" : img,
      "duration" : duration,
      "category" : category,
      "glutenFree" : glutenFree,
      "lactoseFree" : lactoseFree,
      "vegan" : vegan,
      "vegetarian" : vegetarian,
      "favorite" : favorite
    });
  }

  Future<void> insertIngredients(String uidMeal, String name) async{
    await _database.insert("ingredient", {"uidMeal" : uidMeal, "name" : name });
  }

  Future<void> insertStep(String uidMeal, String name) async{
    await _database.insert("step",{ "uidMeal" : uidMeal, "name" : name});
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