import 'dart:async';
import 'dart:io';
import 'package:app_refeicoes/models/ingredient.dart';
import 'package:app_refeicoes/pages/registration/registration_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/step.dart';

class RegistrationController{

  TextEditingController textControllerNameMeal = TextEditingController();
  TextEditingController textControllerTimeMeal = TextEditingController();

  TextEditingController textControllerNameIngredients = TextEditingController();
  TextEditingController textControllerNameSteps = TextEditingController();

  StreamController<List<Ingredient>> controllerListIngredients = StreamController<List<Ingredient>>.broadcast();
  StreamController<List<Step>> controllerListSteps = StreamController<List<Step>>.broadcast();
  StreamController<String> controllerDropdownButton = StreamController<String>.broadcast();
  StreamController<String> controllerImage = StreamController<String>.broadcast();
  StreamController<String> controllerRadioComplexity = StreamController<String>.broadcast();
  StreamController<String> controllerRadioCost = StreamController<String>.broadcast();
  
  RegistrationRepository registrationRepository = RegistrationRepository();
  
  List<Ingredient> listIngredients = [];
  List<Step> listSteps = [];


  final ImagePicker _picker = ImagePicker();
  XFile? image;
  String? complexity;
  String? cost;

  Future<void> initMealPage() async{
    await registrationRepository.initDb();
  }

  void updateListIngredients(String uidMeal) async{
    listIngredients.add(Ingredient(uidMeal:uidMeal, name: textControllerNameIngredients.text));
    controllerListIngredients.sink.add(listIngredients);
    textControllerNameIngredients.clear();
  }

  void updateListSteps(String uidMeal){
    listSteps.add(Step(uidMeal: uidMeal, name: textControllerNameSteps.text));
    controllerListSteps.sink.add(listSteps);
    textControllerNameSteps.clear();
  }

  void insertMealDatabase(String uidMeal, String category) async{
    registrationRepository.insertMeal(
      name: textControllerNameMeal.text,
      category: category,
      complexity: complexity!,
      cost: cost!,
      duration: int.parse(textControllerTimeMeal.text),
      favorite: false,
      img: image!.path, 
      uidMeal: uidMeal
    );
  }

  void insertIngredientsDatabase() async{
    for(Ingredient ingredient in listIngredients){
        await registrationRepository.insertIngredients(ingredient.uidMeal, ingredient.name);
    }
  }

  void insertStepDatabase(String uidMeal) async{
    for(Step step in listSteps){
      await registrationRepository.insertStep(step.name!, uidMeal);
    }
  }

  Future<void> takePhotoFromGallery() async{
    image = await _picker.pickImage(source: ImageSource.gallery);
    if(image != null && image!.path.isNotEmpty){
    controllerImage.sink.add(image!.path);
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