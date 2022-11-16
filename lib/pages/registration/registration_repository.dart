import 'package:app_refeicoes/db/database_provider.dart';
import 'package:app_refeicoes/models/meal.dart';
import 'package:sqflite/sqflite.dart';

class RegistrationRepository{
  late final Database _database;

  Future<void> initDb() async{
    _database = await DBProvider.db.database;
  }

  Future<void> insertMeal(
    String name, 
    String cost,
    String complexity,
    String img,
    int duration,
    String category,
    String mealIngredients,
    String mealSteps,
    int glutenFree,
    int lactoseFree,
    int vegan,
    int vegetarian,
    int favorite
  ) async{
    await _database.insert("meal", {
      "name" : name,
      "cost" : cost,
      "complexity" : complexity,
      "img" : img,
      "duration" : duration,
      "category" : category,
      "mealIngredient" : mealIngredients,
      "mealSteps" : mealSteps,
      "glutenFree" : glutenFree,
      "lactoseFree" : lactoseFree,
      "vegan" : vegan,
      "vegetarian" : vegetarian,
      "favorite" : favorite
    });
  }

   Future<List<Meal>> findAllMeals() async {
    var mealMap = await _database.rawQuery("SELECT * FROM meal");
    return Meal.fromMapList(mealMap);
  }
}