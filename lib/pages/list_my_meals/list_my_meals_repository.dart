
import 'package:app_refeicoes/database/objectbox.g.dart';
import 'package:app_refeicoes/database/objectbox_database.dart';
import 'package:app_refeicoes/models/checkbox_controller.dart';
import 'package:app_refeicoes/models/meal.dart';

class ListMyMealsRepository{

  List<Meal> findAllMeals(){
   return ObjectBox.mealId.getAll();
  }

  List<Meal> findMealsCrescentOrDescending(bool? isAsc, List<CheckboxController> controllers){

    QueryBuilder<Meal>? query;

    if(isAsc == true){

      query = filterMeals(controllers)..order(Meal_.name);
       
      return query.build().find();
    }else if(isAsc == false){
      
      query = filterMeals(controllers)..order(Meal_.name, flags: Order.descending);
      return query.build().find();

    }else{

      return filterMeals(controllers).build().find();

    }
  }
  QueryBuilder<Meal> filterMeals(List<CheckboxController> controllers){
    return ObjectBox.mealId.query(
      filter(
        controllers.where((element) => element.category == "Custo").toList(),
        controllers.where((element) => element.category == "Dificuldade").toList()
      )
    );
  }

  Condition<Meal>? filter(List<CheckboxController> listCost, List<CheckboxController> listComplexity){
    
    if(listCost.isNotEmpty && listComplexity.isNotEmpty){

      List<String> costs = listCost.map((e) => e.name!).toList();
      List<String> complexity = listComplexity.map((e) => e.name!).toList();

      return Meal_.cost.oneOf(costs).and(Meal_.complexity.oneOf(complexity));

    }else if(listCost.isNotEmpty){

      List<String> costs = listCost.map((e) => e.name!).toList();
      return Meal_.cost.oneOf(costs);
    
    }else if(listComplexity.isNotEmpty){

      List<String> complexity = listComplexity.map((e) => e.name!).toList();
      return Meal_.complexity.oneOf(complexity);

    }else{
      return null;
    }
    
  }



}