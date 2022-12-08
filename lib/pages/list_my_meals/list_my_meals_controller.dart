import 'package:app_refeicoes/models/meal.dart';
import 'package:app_refeicoes/pages/list_my_meals/list_my_meals_repository.dart';
import 'package:rxdart/subjects.dart';

class ListMyMealController{

  ListMyMealsRepository listMyMealsRepository = ListMyMealsRepository();
  BehaviorSubject<List<Meal>> controllerMyListMeals = BehaviorSubject<List<Meal>>();

  Future<void> initListMyMealsPage() async{
    listMyMealsRepository.initDb();
    controllerMyListMeals.sink.add(listMyMealsRepository.findAllMeals());
  }

}