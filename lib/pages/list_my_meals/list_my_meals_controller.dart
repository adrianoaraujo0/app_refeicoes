import 'package:app_refeicoes/models/checkbox_controller.dart';
import 'package:app_refeicoes/models/icon_button_controller.dart';
import 'package:app_refeicoes/models/meal.dart';
import 'package:app_refeicoes/pages/list_my_meals/list_my_meals_repository.dart';
import 'package:rxdart/subjects.dart';

class ListMyMealController{

  ListMyMealsRepository listMyMealsRepository = ListMyMealsRepository();
  BehaviorSubject<List<Meal>> controllerMyListMeals = BehaviorSubject<List<Meal>>();
  BehaviorSubject<IconButtonController> controllerIconButton =  BehaviorSubject<IconButtonController>();
  BehaviorSubject<CheckboxController> controllerCheckbox =  BehaviorSubject<CheckboxController>();

  Future<void> initListMyMealsPage() async{
    controllerMyListMeals.sink.add(listMyMealsRepository.findAllMeals());
  }

  Future<void> orderList() async{
    controllerMyListMeals.sink.add(listMyMealsRepository.filterMeals());
    // listMyMealsRepository.filterMeals();
    // controllerMyListMeals.sink.add(listMyMealsRepository.findAMeals(order));
  }
  


}