import 'package:app_refeicoes/models/checkbox_controller.dart';
import 'package:app_refeicoes/models/icon_button_controller.dart';
import 'package:app_refeicoes/models/meal.dart';
import 'package:app_refeicoes/pages/list_my_meals/list_my_meals_repository.dart';
import 'package:rxdart/subjects.dart';

class ListMyMealController{

  ListMyMealsRepository listMyMealsRepository = ListMyMealsRepository();
  BehaviorSubject<List<Meal>> controllerMyListMeals = BehaviorSubject<List<Meal>>();
  BehaviorSubject<IconButtonController> controllerIconButton =  BehaviorSubject<IconButtonController>();
  BehaviorSubject<List<CheckboxController>> controllerCheckbox = BehaviorSubject<List<CheckboxController>>();

  Future<void> initListMyMealsPage() async{
    controllerMyListMeals.sink.add(listMyMealsRepository.findAllMeals());
  }

  Future<void> orderCrescentDescending(bool? isAsc, List<CheckboxController> controller) async{
    controllerMyListMeals.sink.add(
      listMyMealsRepository.findMealsCrescentOrDescending(isAsc, controller)
    );
  }

  // Future<void> orderList(List<CheckboxController> controller) async{
  //   controllerMyListMeals.sink.add(listMyMealsRepository.filterMeals(controller).order(Meal()));
    
  // }

}