import 'package:app_refeicoes/database/objectbox_database.dart';
import 'package:app_refeicoes/models/meal.dart';

class MyMealsRepository{

  Meal findAllMeals(int id){
    return ObjectBox.mealId.get(id)!;
  }

}