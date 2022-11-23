import 'dart:async';
import 'package:app_refeicoes/models/form_registration.dart';
import 'package:app_refeicoes/models/ingredient.dart';
import 'package:app_refeicoes/models/meal.dart';
import 'package:app_refeicoes/pages/registration/registration_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/subjects.dart';
import '../../models/step_meal.dart';

class RegistrationController{

  TextEditingController textControllerNameMeal = TextEditingController();
  TextEditingController textControllerTimeMeal = TextEditingController();

  TextEditingController textControllerNameIngredients = TextEditingController();
  TextEditingController textControllerNameSteps = TextEditingController();

  BehaviorSubject<FormRegistration> controllerFormRegistration = BehaviorSubject<FormRegistration>();
  BehaviorSubject<List<IngredientMeal>> controllerListIngredients = BehaviorSubject<List<IngredientMeal>>();
  BehaviorSubject<List<StepMeal>> controllerListSteps = BehaviorSubject<List<StepMeal>>();
  BehaviorSubject<String> controllerDropdownButton = BehaviorSubject<String>();
  BehaviorSubject<String> controllerImage = BehaviorSubject<String>();
  BehaviorSubject<String> controllerRadioComplexity = BehaviorSubject<String>();
  BehaviorSubject<String> controllerRadioCost = BehaviorSubject<String>();
  BehaviorSubject<bool> controllereExpasionListIngredients = BehaviorSubject<bool>();
  BehaviorSubject<bool> controllereExpasionListSteps = BehaviorSubject<bool>();
  
  RegistrationRepository registrationRepository = RegistrationRepository();
  
  List<IngredientMeal> listIngredients = [];
  List<StepMeal> listSteps = [];
  List<String> listTitleExpansionList = ["Insira os ingredientes", "Insira os passos"];

  FormRegistration formRegistration = FormRegistration();
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  String? complexity;
  String? cost;

  Future<void> initDb() async{
    await registrationRepository.initDb();
  }

  void updateForm(FormRegistration formRegistration){
    controllerFormRegistration.sink.add(formRegistration);
  }

  // void updateListIngredients() async{
  //   listIngredients.add(Ingredient(name: textControllerNameIngredients.text, isExpanded: false));
  //   controllerListIngredients.sink.add(listIngredients);
  //   textControllerNameIngredients.clear();
  // }

  // void updateListSteps(){
  //   listSteps.add(Step(name: textControllerNameSteps.text, isExpanded: false));
  //   controllerListSteps.sink.add(listSteps);
  //   textControllerNameSteps.clear();
  // }

  void initFormRegistration(int id){
    formRegistration =  FormRegistration(
        meal: Meal(id: id, category: null, name: null, imgUrl: null, duration: null, complexity: null, cost: null),
        ingredient: IngredientMeal(idMeal: id, name: null, isExpanded: false),
        step: StepMeal(idMeal: id, name: null, isExpanded: false)
      );
    controllerFormRegistration.sink.add(formRegistration);
  }

  void insertMealDatabase({String? category}) async{
    registrationRepository.insertMeal(
      name: textControllerNameMeal.text,
      category: category,
      complexity: complexity,
      cost: cost,
      duration: textControllerTimeMeal.text.isNotEmpty ? int.parse(textControllerTimeMeal.text) : 0,
      favorite: false,
      img: image?.path
    );
  }

  void insertIngredientsDatabase() async{
    for(IngredientMeal ingredient in listIngredients){
        await registrationRepository.insertIngredients(ingredient.idMeal!,ingredient.name);
    }
  }

  void insertStepDatabase() async{
    for(StepMeal step in listSteps){
      await registrationRepository.insertStep(step.idMeal!, step.name!);
    }
  }

  Future<void> takePhotoFromGallery() async{
    image = await _picker.pickImage(source: ImageSource.gallery);
    if(image != null && image!.path.isNotEmpty){
      // controllerFormRegistration.sink.add();
    }
  }

  Future<int> idLastMeal() async{
    Meal lastMeal =  await registrationRepository.findLastMeal();
    return lastMeal.id;
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