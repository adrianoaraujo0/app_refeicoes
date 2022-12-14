import 'dart:async';
import 'package:app_refeicoes/models/meal.dart';
import 'package:app_refeicoes/models/text_field_expansion_list.dart';
import 'package:app_refeicoes/pages/registration/registration_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/subjects.dart';

class RegistrationController{

  bool validatorWillPopScope = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController textControllerNameMeal = TextEditingController();
  TextEditingController textControllerTimeMeal = TextEditingController();

  BehaviorSubject<Meal> controllerMeal = BehaviorSubject<Meal>();
  
  RegistrationRepository registrationRepository = RegistrationRepository();
  
  List<TextFieldExpansionList> textFieldExpansionList = [
    TextFieldExpansionList(id: "Ingredientes", controller: TextEditingController()),
    TextFieldExpansionList(id: "Passos", controller: TextEditingController()),
  ];

  void updateForm(Meal meal){
    controllerMeal.sink.add(meal);
  }

  Future<void> initMeal() async{
    controllerMeal.sink.add(Meal(ingredientMeal: [], stepMeal: []));
  }

  void insertMealDatabase([Meal? meal]) async{
    registrationRepository.insertMeal(meal!.name!, meal.category!, meal.imgUrl!, meal.duration!, meal.complexity!, meal.cost!, meal.stepMeal!, meal.ingredientMeal!);
  }


  Future<void> takePhotoFromGallery(Meal meal) async{

    final ImagePicker picker = ImagePicker();
    XFile?  image = await picker.pickImage(source: ImageSource.gallery);

    if(image != null){
      meal.imgUrl = image.path;
      controllerMeal.sink.add(meal);
    }
  }

  void insertItemListIngredients(Meal meal){
    meal.ingredientMeal!.add(textFieldExpansionList[0].controller.text);
    controllerMeal.add(meal);
    textFieldExpansionList[0].controller.clear();
  }

  void insertItemListStep(Meal meal){
    meal.stepMeal!.add(textFieldExpansionList[1].controller.text);
    controllerMeal.add(meal);
    textFieldExpansionList[1].controller.clear();
  }

  void validatorInsertList(String validator, Meal meal){
    if(validator == "Ingredientes"){
      insertItemListIngredients(meal);
    }else {
      insertItemListStep(meal);
    }
  }

  void removeItemListIngredients(Meal meal ,int index){
    meal.ingredientMeal!.removeAt(index);
    controllerMeal.sink.add(meal);
  }

   void removeItemListStep(Meal meal, int index){
    meal.stepMeal!.removeAt(index);
    controllerMeal.add(meal);
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


  String validationForm(Meal meal, BuildContext context){
    if(meal.imgUrl == null ||  meal.imgUrl!.isEmpty){

      formKey.currentState!.validate();

      return "Adicione uma imagem";

    }else if(textControllerNameMeal.text.isEmpty){
      
      formKey.currentState!.validate();
      
      return "Adicione o nome da receita";

    }else if(meal.category == null || meal.category!.isEmpty){
      
      formKey.currentState!.validate();
      
      return "Escolha a categoria da receita";

    }else if(textControllerTimeMeal.text.isEmpty){
      
      formKey.currentState!.validate();
      
      return "Adicione o tempo da receita";

    }else if(meal.complexity == null || meal.complexity!.isEmpty){
      
      formKey.currentState!.validate();
      
      return "Escolha a dificuldade da receita";

    }else if(meal.cost == null){
      
      formKey.currentState!.validate();
      
      return "Escolha o custo da receita";

    }else if(meal.ingredientMeal!.isEmpty){
      
      formKey.currentState!.validate();
      
      return "Insira pelo menos 1 ingrediente";

    }else if(meal.stepMeal!.isEmpty){
      
      formKey.currentState!.validate();
      
      return "Insira pelo menos 1 passo";

    }
    else {
      insertMealDatabase(meal);
      Navigator.pop(context);
      return "Receita salva com sucesso!";
    }
    
  }
}