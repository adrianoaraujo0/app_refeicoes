
import 'package:app_refeicoes/database/objectbox.g.dart';
import 'package:app_refeicoes/database/objectbox_database.dart';
import 'package:app_refeicoes/models/meal.dart';

class ListMyMealsRepository{

  late final Box<Meal>  mealId;

  Future<void> initDb() async{
    mealId = ObjectBox.store.box<Meal>();
  }

  List<Meal> findAllMeals(){
   return mealId.getAll();
  }

}