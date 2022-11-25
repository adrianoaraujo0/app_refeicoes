import 'dart:async';
import 'dart:developer';
import 'package:app_refeicoes/models/ingredient_meal.dart';
import 'package:app_refeicoes/models/meal.dart';
import 'package:app_refeicoes/pages/registration/registration_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/subjects.dart';
import '../../models/step_meal.dart';

class RegistrationController{

  TextEditingController textControllerNameMeal = TextEditingController();
  TextEditingController textControllerTimeMeal = TextEditingController();

  TextEditingController textControllerNameIngredient = TextEditingController();
  TextEditingController textControllerNameStep = TextEditingController();

  BehaviorSubject<Meal> controllerMeal = BehaviorSubject<Meal>();
  
  RegistrationRepository registrationRepository = RegistrationRepository();
  
  List<IngredientMeal> listIngredients = [];
  List<StepMeal> listSteps = [];
  List<String> listTitleExpansionList = ["Insira os ingredientes", "Insira os passos"];
  


  final formKey= GlobalKey<FormState>();


  Future<void> initDb() async{
    await registrationRepository.initDb();
  }

  void updateForm(Meal meal){
    controllerMeal.sink.add(meal);
  }

  void initMeal(int id){
    controllerMeal.sink.add(Meal(id: id));
  }

  void insertMealDatabase({String? category}) async{
    registrationRepository.insertMeal(
      name: null,
      category: null,
      complexity: null,
      cost: null,
      duration: null,
      favorite: false,
      imgUrl: null
    );
  }

  void insertIngredientsDatabase() async{
    for(IngredientMeal ingredient in listIngredients){
        await registrationRepository.insertIngredients(ingredient.mealId!,ingredient.name);
    }
  }

  void insertStepDatabase() async{
    for(StepMeal step in listSteps){
      await registrationRepository.insertStep(step.mealId!, step.name!);
    }
  }

  Future<void> takePhotoFromGallery(Meal meal) async{

    final ImagePicker picker = ImagePicker();
    XFile?  image = await picker.pickImage(source: ImageSource.gallery);

    if(image != null){
      meal.imgUrl = image.path;
      controllerMeal.sink.add(meal);
    }
  }

  void insertListIngredients(Meal meal){
    listIngredients.add(IngredientMeal(mealId: meal.id, name: textControllerNameIngredient.text));
    meal.ingredientMeal = listIngredients;
    controllerMeal.sink.add(meal);
  }

  void insertListStep(Meal meal){
    listSteps.add(StepMeal(mealId: meal.id, name: textControllerNameStep.text));
    meal.stepMeal = listSteps;
    controllerMeal.sink.add(meal);
  }

  void insertCategory(Meal meal, String newTitle){
    meal.category = newTitle;
    controllerMeal.sink.add(meal);
  }

   void insertComplexity(Meal meal, String complexity){
    meal.complexity = complexity;
    controllerMeal.sink.add(meal);
  }

  void insertCost(Meal meal, String cost){
    meal.cost = cost;
    controllerMeal.sink.add(meal);
  }

  void changeExpansionListIngredient(Meal meal, bool isExpanded){
    meal.ingredientIsExpanded = !isExpanded;
    controllerMeal.sink.add(meal);
  }

  void changeExpansionListStep(Meal meal, bool isExpanded){
    meal.stepIsExpanded = !isExpanded;
    controllerMeal.sink.add(meal);
  }

  Future<int> idLastMeal() async{
    Meal lastMeal =  await registrationRepository.findLastMeal();
    return lastMeal.id!;
  }

  void formVerification() async{
   formKey.currentState!.validate();
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