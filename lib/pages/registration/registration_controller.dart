import 'dart:async';
import 'package:app_refeicoes/pages/registration/registration_repository.dart';
import 'package:flutter/cupertino.dart';

class RegistrationController{

  TextEditingController textControllerIngredients = TextEditingController();
  TextEditingController textControllerSteps = TextEditingController();

  StreamController<List<String>> controllerListIngredients = StreamController<List<String>>.broadcast();
  StreamController<List<String>> controllerListSteps =StreamController<List<String>>.broadcast();
  
  RegistrationRepository registrationRepository = RegistrationRepository();
  
  List<String> listIngredients = [];
  List<String> listSteps = [];

  void initMealPage(){
    registrationRepository.initDb();
  }

  void insertMeal() async{
     await registrationRepository.insertMeal("TESTE", "TESTE", "TESTE", "TESTE", 1, "TESTE", "TESTE", "TESTE", 0, 1, 1, 1, 1);
    List x = await registrationRepository.findAllMeals(); 

   print(x);
    
  }

  void updateListIngredients(){
     listIngredients.add(textControllerIngredients.text);
     controllerListIngredients.sink.add(listIngredients);
     textControllerIngredients.clear();
  }

  void updateListSteps(){
     listSteps.add(textControllerSteps.text);
     controllerListSteps.sink.add(listSteps);
     textControllerSteps.clear();
  }
}