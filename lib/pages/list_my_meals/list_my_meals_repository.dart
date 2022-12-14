
import 'package:app_refeicoes/database/objectbox_database.dart';
import 'package:app_refeicoes/models/meal.dart';

class ListMyMealsRepository{


  List<Meal> findAllMeals(){
   return ObjectBox.mealId.getAll();
  }


  // List<Meal> findAllMeals(){
  //  return ObjectBox.mealId.getAll().
  // }



}