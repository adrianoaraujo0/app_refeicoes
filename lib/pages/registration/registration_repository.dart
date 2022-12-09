import 'package:app_refeicoes/database/objectbox_database.dart';
import 'package:app_refeicoes/models/meal.dart';
import 'package:objectbox/objectbox.dart';

class RegistrationRepository{

   
 

    void closeDb() {
      ObjectBox.store.close;
    }

    Future<void> insertMeal(String name, String category, String imgUrl, double duration, String complexity, String cost, List<String> steps, List<String> ingredients) async{
      Meal meal = Meal(name: name, category: category,imgUrl: imgUrl, duration: duration, complexity: complexity, cost: cost, ingredientMeal: ingredients, stepMeal: steps);
     ObjectBox.mealId.put(meal);
    }

    List<Meal> findAllMeal(){
      return ObjectBox.mealId.getAll();
    }


}