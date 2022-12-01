import 'package:app_refeicoes/models/meal.dart';
import 'package:app_refeicoes/pages/my_meal/my_meal_repository.dart';
import 'package:rxdart/subjects.dart';

class MyMealController{

  BehaviorSubject<Meal> controllerMyMeal = BehaviorSubject();

  MyMealRepository myMealRepository = MyMealRepository();

  Future<void> initMyMealPage(Meal meal) async{
    await myMealRepository.initDb();
    meal.ingredientMeal = await myMealRepository.findAllIngredients(meal.id!);
    meal.stepMeal = await myMealRepository.findAllSteps(meal.id!);
    controllerMyMeal.sink.add(meal);
  }
}

