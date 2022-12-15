
import 'package:app_refeicoes/database/objectbox.g.dart';
import 'package:app_refeicoes/database/objectbox_database.dart';
import 'package:app_refeicoes/models/checkbox_controller.dart';
import 'package:app_refeicoes/models/meal.dart';

class ListMyMealsRepository{

  List<Meal> findAllMeals(){
   return ObjectBox.mealId.getAll();
  }

  List<Meal> findMealsCrescentOrDescending(bool? isAsc){

    QueryBuilder<Meal>? query;

    if(isAsc == true){
      query = ObjectBox.mealId.query()..order(Meal_.name);
      return query.build().find();
      
    }else if(isAsc == false){
      query = ObjectBox.mealId.query()..order(Meal_.name, flags: Order.descending);
      return query.build().find();
    }else{
      return findAllMeals();
    }


  }

  List<Meal> filterMeals(List<CheckboxController> controllers){

   
    


    print(controllers.where((element) => element.category == "Custo").isEmpty);
    print(controllers.where((element) => element.category == "Dificuldade").isEmpty);
    
 

    final query = ObjectBox.mealId.query(
      Meal_.cost.oneOf([])
      .and(
        Meal_.complexity.oneOf([])
      )
    ).build().find();

    return query;
  }


  filter(List<CheckboxController> controllers){
      if(controllers.where((element) => element.category == "Custo").isEmpty){
        
      }

    
  }



}