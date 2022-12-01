import 'package:app_refeicoes/db/database_provider.dart';
import 'package:app_refeicoes/models/ingredient_meal.dart';
import 'package:app_refeicoes/models/step_meal.dart';
import 'package:sqflite/sqflite.dart';

class MyMealRepository{

  late final Database _database;

  Future<void> initDb() async{
    _database = await DBProvider.db.database;
  }

  Future<List<IngredientMeal>> findAllIngredients(int mealId) async{
    List<Map<String, dynamic>> ingredientMap = await _database.rawQuery("SELECT * FROM ingredient WHERE mealId = $mealId");
    return IngredientMeal.fromMapList(ingredientMap);
  }

  Future<List<StepMeal>> findAllSteps(int mealId) async{
    List<Map<String, dynamic>> stepMap = await _database.rawQuery("SELECT * FROM step WHERE mealId = $mealId");
    return StepMeal.fromMapList(stepMap);
  }

}