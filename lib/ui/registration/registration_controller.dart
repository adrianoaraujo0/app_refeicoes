import 'dart:async';
import 'package:flutter/cupertino.dart';

class RegistrationController{

  TextEditingController textControllerIngredients = TextEditingController();
  TextEditingController textControllerSteps = TextEditingController();

  StreamController<List<String>> controllerListIngredients = StreamController<List<String>>.broadcast();
  StreamController<List<String>> controllerListSteps =StreamController<List<String>>.broadcast();

  List<String> listIngredients = [];
  List<String> listSteps = [];

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