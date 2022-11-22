import 'dart:async';
import 'package:app_refeicoes/models/form_registration.dart';
import 'package:app_refeicoes/models/ingredient.dart';
import 'package:app_refeicoes/pages/registration/registration_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/subjects.dart';
import '../../models/step.dart';

class RegistrationController{

  TextEditingController textControllerNameMeal = TextEditingController();
  TextEditingController textControllerTimeMeal = TextEditingController();

  TextEditingController textControllerNameIngredients = TextEditingController();
  TextEditingController textControllerNameSteps = TextEditingController();

  BehaviorSubject<FormRegistration> controllerForm = BehaviorSubject<FormRegistration>();
  BehaviorSubject<List<Ingredient>> controllerListIngredients = BehaviorSubject<List<Ingredient>>();
  BehaviorSubject<List<Step>> controllerListSteps = BehaviorSubject<List<Step>>();
  BehaviorSubject<String> controllerDropdownButton = BehaviorSubject<String>();
  BehaviorSubject<String> controllerImage = BehaviorSubject<String>();
  BehaviorSubject<String> controllerRadioComplexity = BehaviorSubject<String>();
  BehaviorSubject<String> controllerRadioCost = BehaviorSubject<String>();
  BehaviorSubject<bool> controllereExpasionListIngredients = BehaviorSubject<bool>();
  BehaviorSubject<bool> controllereExpasionListSteps = BehaviorSubject<bool>();
  
  RegistrationRepository registrationRepository = RegistrationRepository();
  
  List<Ingredient> listIngredients = [];
  List<Step> listSteps = [];
  List<String> listTitleExpansionList = ["Insira os ingredientes", "Insira os passos"];

  final ImagePicker _picker = ImagePicker();
  XFile? image;
  String? complexity;
  String? cost;

  Future<void> initBd() async{
    await registrationRepository.initDb();
  }

  void updateForm(FormRegistration formRegistration){
    controllerForm.sink.add(formRegistration);
  }

  void updateListIngredients() async{
    listIngredients.add(Ingredient(name: textControllerNameIngredients.text));
    controllerListIngredients.sink.add(listIngredients);
    textControllerNameIngredients.clear();
  }

  void updateListSteps(){
    listSteps.add(Step(name: textControllerNameSteps.text));
    controllerListSteps.sink.add(listSteps);
    textControllerNameSteps.clear();
  }

  void insertMealDatabase({String? category}) async{
    registrationRepository.insertMeal(
      name: textControllerNameMeal.text,
      category: category,
      complexity: complexity,
      cost: cost,
      duration: int.parse(textControllerTimeMeal.text),
      favorite: false,
      img: image?.path
    );
  }

  void insertIngredientsDatabase() async{
    for(Ingredient ingredient in listIngredients){
        await registrationRepository.insertIngredients(ingredient.name);
    }
  }

  void insertStepDatabase() async{
    for(Step step in listSteps){
      await registrationRepository.insertStep(step.name!);
    }
  }


  Future<void> takePhotoFromGallery() async{
    image = await _picker.pickImage(source: ImageSource.gallery);
    if(image != null && image!.path.isNotEmpty){
    controllerImage.sink.add(image!.path);
    controllerForm.sink.add(FormRegistration());
    }
  }

  void updateRadioComplexity(String value){
    complexity = value;
    controllerRadioComplexity.sink.add(value);
  }

  void updateRadioCost(String value){
    cost = value;
    controllerRadioCost.sink.add(value);
  }

  void printTables() async{
    print("-------------Meal------------------------");
    for(var x in await registrationRepository.findAllMeals()){
      print(x.toString());
    }
    print("-------------INGREDIENTS------------------------");
    for(var x in await registrationRepository.findAllIngredients()){
      print(x.toString());
    }
    print("-------------Steps------------------------");
     for(var x in await registrationRepository.findAllSteps()){
      print(x.toString());
    }
  }
}