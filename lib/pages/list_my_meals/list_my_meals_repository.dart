
import 'package:app_refeicoes/database/objectbox.g.dart';
import 'package:app_refeicoes/database/objectbox_database.dart';
import 'package:app_refeicoes/models/meal.dart';

class ListMyMealsRepository{


  List<Meal> findAllMeals(){
   return ObjectBox.mealId.getAll();
  }


  List<Meal> findAMeals(String order){
    final query = ObjectBox.mealId.query()..order(Meal_.cost, flags: Order.descending);
    return query.build().find();
  }

  List<Meal> filterMeals(){
    final query = ObjectBox.mealId.query(
      (Meal_.cost.contains("Barato").or(Meal_.cost.contains("Razoável")).or(Meal_.cost.contains("Caro"))
      .and(Meal_.complexity.contains("").or(Meal_.complexity.contains("Razoável")).or(Meal_.complexity.contains("Difícil")))



    )).build().find();



    final query2 = ObjectBox.mealId.query(Meal_.complexity.contains("Fácil").or(Meal_.complexity.contains("Médio"))).build().find();
        // .and(Meal_.complexity.contains("Fácil").or(Meal_.complexity.contains("Razoável")).or(Meal_.complexity.contains("Difícil")))
  
    print(query.length);


    return query;
  }



}