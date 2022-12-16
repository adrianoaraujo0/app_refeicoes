import 'package:app_refeicoes/models/checkbox_controller.dart';
import 'package:app_refeicoes/models/icon_button_controller.dart';
import 'package:app_refeicoes/models/meal.dart';
import 'package:app_refeicoes/pages/list_my_meals/list_my_meals_repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class ListMyMealController{

  ListMyMealsRepository listMyMealsRepository = ListMyMealsRepository();
  BehaviorSubject<List<Meal>> controllerMyListMeals = BehaviorSubject<List<Meal>>();
  BehaviorSubject<IconButtonController> controllerIconButton =  BehaviorSubject<IconButtonController>();
  BehaviorSubject<List<CheckboxController>> controllerCheckbox = BehaviorSubject<List<CheckboxController>>();

  void updateListMyMealsPage(){
    controllerMyListMeals.sink.add(listMyMealsRepository.findAllMeals());
  }

  void orderCrescentDescending(bool? isAsc, List<CheckboxController> controller) {
    controllerMyListMeals.sink.add(
      listMyMealsRepository.findMealsCrescentOrDescending(isAsc, controller)
    );
  }

  void deleteMeal(BuildContext context, Meal meal){
    listMyMealsRepository.deleteMeal(meal.id!);
    updateListMyMealsPage();
    undoMealRemoval(context, meal);
  }

  void insertMeal(Meal meal){
    listMyMealsRepository.insertMeal(meal);
  }


  undoMealRemoval(BuildContext context, Meal meal){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Desfazer exclusão."),
        action: SnackBarAction(
          label: "Desfazer.",
          onPressed: () {
            listMyMealsRepository.insertMeal(meal);
            updateListMyMealsPage();
          },
        ),
      )
    );
  }



}