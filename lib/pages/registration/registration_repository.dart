import 'package:app_refeicoes/db/database_provider.dart';
import 'package:app_refeicoes/models/ingredient_meal.dart';
import 'package:app_refeicoes/models/meal.dart';
import 'package:app_refeicoes/models/step_meal.dart';
import 'package:sqflite/sqflite.dart';

class RegistrationRepository{
  late final Database _database;

  Future<void> initDb() async{
    _database = await DBProvider.db.database;
  }

  Future<void> insertMeal({String? name, String? cost,String? complexity,String? imgUrl, double? duration,String? category}) async{
    await _database.insert(
      "meal", 
    {
      "name" : name,
      "cost" : cost,
      "complexity" : complexity,
      "imgUrl" : imgUrl,
      "duration" : duration,
      "category" : category,
    }
    );
  }

  Future<void> updateMeal({int? id, String? name, String? cost,String? complexity,String? imgUrl, double? duration,String? category}) async{
    await _database.rawUpdate("UPDATE meal SET name = '$name', cost = '$cost', complexity = '$complexity', imgUrl = '$imgUrl', duration = $duration, category = '$category' WHERE id = $id");
  }

  Future<void> removeMeal(int id) async{
   await _database.rawDelete("DELETE FROM meal WHERE id = $id");
  }

  Future<void> insertIngredients(int mealId, String? name) async{
    await _database.insert("ingredient", {"mealId" : mealId ,"name" : name});
  }

  Future<void> insertStep(int mealId, String? name) async{
    await _database.insert("step",{"mealId" : mealId ,"name" : name});
  }

  Future<List<Meal>> findAllMeals() async {
    List<Map<String, dynamic>> mealMap = await _database.rawQuery("SELECT * FROM meal");
    
    return Meal.fromMapList(mealMap);
  }

  Future<Meal> findLastMeal() async {
    List<Meal> x = await findAllMeals();
    return x.last;
  }
  
  Future<List<IngredientMeal>> findAllIngredients() async{
    List<Map<String, dynamic>> ingredientMap = await _database.rawQuery("SELECT * FROM ingredient");
    
    // INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)'
    return IngredientMeal.fromMapList(ingredientMap);
  }

  Future<List<StepMeal>> findAllSteps() async{
    List<Map<String, dynamic>> stepMap = await _database.rawQuery("SELECT * FROM step");
    return StepMeal.fromMapList(stepMap);
  }
}