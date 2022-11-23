import 'dart:async';
import 'dart:developer';
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
  String? imgUrl;
  String? complexity;
  String? category;
  String? cost;

  Future<void> initDb() async{
    await registrationRepository.initDb();
  }

  void updateForm(FormRegistration formRegistration){
    controllerFormRegistration.sink.add(formRegistration);
  }


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
    print("1 ${textControllerNameMeal.text}");
    image = await _picker.pickImage(source: ImageSource.gallery);
    print("2 $image");
    if(image != null && image!.path.isNotEmpty){
    }
  }

  Future<int> idLastMeal() async{
    Meal lastMeal =  await registrationRepository.findLastMeal();
    return lastMeal.id!;
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
    
    for(var x in await registrationRepository.findAllMeals()){
      log(x.toString());
    }

    for(var x in await registrationRepository.findAllIngredients()){
      log(x.toString());
    }

     for(var x in await registrationRepository.findAllSteps()){
      log(x.toString());
    }
  }
}