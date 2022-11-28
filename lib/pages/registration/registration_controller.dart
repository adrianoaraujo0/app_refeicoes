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
    textControllerNameIngredient.clear();
  }

  void removeItemListIngredients(Meal meal ,int index){
    listIngredients.removeAt(index);
    meal.ingredientMeal = listIngredients;
    controllerMeal.sink.add(meal);
    textControllerNameStep.clear();
  }

  void insertListStep(Meal meal){
    listSteps.add(StepMeal(mealId: meal.id, name: textControllerNameStep.text));
    meal.stepMeal = listSteps;
    controllerMeal.sink.add(meal);
    textControllerNameStep.clear();
  }

   void removeItemListStep(Meal meal, int index){
    listSteps.removeAt(index);
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

  void validationExpansionList(bool changeToStep, Meal meal){
     formKey.currentState!.validate();

     if(changeToStep){
      if(textControllerNameIngredient.text.isNotEmpty){
        insertListIngredients(meal);
      }
     }else{
      if(textControllerNameStep.text.isNotEmpty){
        insertListStep(meal);
      }
     }
  }

  String validationForm(Meal meal){
    if(meal.imgUrl == null ||  meal.imgUrl!.isEmpty){
      return "Adicione uma imagem";
    }else if(textControllerNameMeal.text.isEmpty){
      return "Adicione o nome da receita";
    }else if(meal.category == null || meal.category!.isEmpty){
      return "Escolha a categoria da receita";
    }else if(textControllerTimeMeal.text.isEmpty){
      return "Adicione o tempo da receita";
    }else if(meal.complexity == null || meal.complexity!.isEmpty){
      return "Escolha a dificuldade da receita";
    }else if(meal.cost == null){
      return "Escolha o custo da receita";
    }else if(meal.ingredientMeal.isEmpty){
      return "Insira pelo menos 1 ingrediente";
    }else if(meal.stepMeal.isEmpty){
      return "Insira pelo menos 1 passo";
    }else {
      // insertMealDatabase();
      return "Receita salva com sucesso!";
    }
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