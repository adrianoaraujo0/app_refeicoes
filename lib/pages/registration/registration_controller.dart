import 'dart:async';
import 'package:app_refeicoes/models/ingredient.dart';
import 'package:app_refeicoes/pages/registration/registration_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/step.dart';

class RegistrationController{

  String? cost;
  String? complexity;
  String? category;
  bool? glutenFree;
  bool? lactoseFree;
  bool? vegan;
  bool? vegetarian;
  bool? favorite;

  TextEditingController textControllerNameMeal = TextEditingController();
  TextEditingController textControllerTimeMeal = TextEditingController();

  TextEditingController textControllerNameIngredients = TextEditingController();
  TextEditingController textControllerNameSteps = TextEditingController();

  StreamController<List<Ingredient>> controllerListIngredients = StreamController<List<Ingredient>>.broadcast();
  StreamController<List<Step>> controllerListSteps = StreamController<List<Step>>.broadcast();
  StreamController<String> controllerDropdownButton = StreamController<String>.broadcast();
  
  RegistrationRepository registrationRepository = RegistrationRepository();
  
  List<Ingredient> listIngredients = [];
  List<Step> listSteps = [];

  final ImagePicker _picker = ImagePicker();
  XFile? image;

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

  void insertMealDatabase(String uidMeal) async{
    print("name: ${textControllerNameMeal.text}");
    print("time: ${textControllerTimeMeal.text}");
    print("uidMeal: ${uidMeal.toString()}");
    print("cost: $cost");
    print("complexity: $complexity");
    print("imgUrl: ${image!.path}");
    print("duration: ${textControllerTimeMeal.text}");
    print("category: ${category}");
    print("glutenFree: $glutenFree");
    print("lactoseFree: $lactoseFree");
    print("vegan: $vegan");
    print("vegetarian: $vegetarian");
    print("favorite: $favorite");
  }

  // void insertMealDatabase(Meal meal) async{
  //   await registrationRepository.insertMeal(
  //     meal.name,
  //     meal.uidMeal,
  //     meal.cost,
  //     meal.complexity,
  //     meal.imgUrl,
  //     meal.duration,
  //     meal.category,
  //     meal.glutenFree,
  //     meal.lactoseFree,
  //     meal.vegan,
  //     meal.vegetarian,
  //     meal.favorite
  //   );
  // }

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

  Future<void> takePhotoFromGallery() async{
    image = await _picker.pickImage(source: ImageSource.gallery);
  }

  void printTables() async{
    print("-------------Meal------------------------");
    for(var x in await registrationRepository.findAllMeals()){
      print("${x.id}, ${x.name}, ${x.uidMeal}");
    }
    print("-------------INGREDIENTS------------------------");
    for(var x in await registrationRepository.findAllIngredients()){
      print("${x.id}, ${x.name}, ${x.uidMeal}");
    }
    print("-------------Steps------------------------");
     for(var x in await registrationRepository.findAllSteps()){
      print("${x.id}, ${x.name}, ${x.uidMeal}");
    }
  }
}