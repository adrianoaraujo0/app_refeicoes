import 'dart:async';
import 'package:app_refeicoes/models/ingredient.dart';
import 'package:app_refeicoes/pages/registration/registration_repository.dart';
import 'package:flutter/cupertino.dart';

import '../../models/step.dart';

class RegistrationController{

  TextEditingController textControllerIngredients = TextEditingController();
  TextEditingController textControllerSteps = TextEditingController();

  StreamController<List<Ingredient>> controllerListIngredients = StreamController<List<Ingredient>>.broadcast();
  StreamController<List<Step>> controllerListSteps = StreamController<List<Step>>.broadcast();
  
  RegistrationRepository registrationRepository = RegistrationRepository();
  
  List<Ingredient> listIngredients = [];
  List<Step> listSteps = [];

  Future<void> initMealPage() async{
    await registrationRepository.initDb();
  }

  void insertMeal() async{
   List x = await registrationRepository.findAllMeals(); 
  }


  void updateListIngredients(String uidMeal) async{
    listIngredients.add(Ingredient(uidMeal:uidMeal, name: textControllerIngredients.text));
    controllerListIngredients.sink.add(listIngredients);
    textControllerIngredients.clear();
  }

  void updateListSteps(String uidMeal){
    
    listSteps.add(Step(uidMeal: uidMeal, name: textControllerSteps.text));
    controllerListSteps.sink.add(listSteps);
    textControllerSteps.clear();
  }

  void insertIngredientsDatabase() async{
    for(Ingredient ingredient in listIngredients){
        await registrationRepository.insertIngredients(ingredient.uidMeal ,ingredient.name);
    }
  }

  void insertStepDatabase(String uidMeal) async{
    for(Step step in listSteps){
      await registrationRepository.insertStep(step.name, step.name);
    }
  }

  void printTables() async{

    // print("-------------Meal------------------------");
    // for(var x in await registrationRepository.findAllMeals()){
    //   print("${x.id}, ${x.name}, ${x.uidMeal}");
    // }

    print("-------------INGREDIENTS------------------------");
    for(var x in await registrationRepository.findAllIngredients()){
      print("${x.id}, ${x.name}, ${x.uidMeal}");
    }
    print("-------------INGREDIENTS------------------------");
     for(var x in await registrationRepository.findAllIngredients()){
      print("${x.id}, ${x.name}, ${x.uidMeal}");
    }

  }
}