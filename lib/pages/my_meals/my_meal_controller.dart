import 'dart:io';
import 'dart:math';

import 'package:app_refeicoes/models/meal.dart';
import 'package:app_refeicoes/pages/my_meals/my_meals_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class MyMealsController{

  MyMealsRepository myMealsRepository = MyMealsRepository();
  BehaviorSubject<Meal> controllerMyMeal = BehaviorSubject();
  BehaviorSubject<bool> controllerFloatingActionButton = BehaviorSubject<bool>();


  Future<void> initMyMealPage(int id) async{
    Meal meal = myMealsRepository.findAllMeals(id);
    controllerMyMeal.sink.add(meal);
  }

  void insertMealInFirebase(Meal meal, BuildContext context) async{
  
      // controllerFloatingActionButton.sink.add(false);

   
      // UploadTask uploadTask;
      print(ConnectionState.active);
      print("123");
      // FirebaseStorage.instance.ref(meal.id.toString()).putFile(File(meal.imgUrl!));
        

      // uploadTask.whenComplete(() async{
      // await FirebaseFirestore.instance.collection("meals")
      // .doc(meal.id.toString())
      // .set(
      //     {
      //       "imgUrl" : await uploadTask.snapshot.ref.getDownloadURL(), 
      //       "name" : meal.name,
      //       "category" : meal.category,
      //       "duration" : meal.duration,
      //       "complexity" : meal.complexity,
      //       "cost" : meal.cost,
      //       "ingredients" : meal.ingredientMeal,
      //       "steps" : meal.stepMeal,
      //       "favorite" : false
      //     },
      //   ).whenComplete(() {
      //     controllerFloatingActionButton.sink.add(true);
      //     buildSnackBarSucess(context);
      //   }
      //   );
      // }).onError((error, stackTrace) {
      //   return throw error!;
      // });
    
    

   //  FirebaseFirestore.instance.collection("meals").doc("1").set({});
  }

    buildSnackBarSucess(BuildContext context){
      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Receita salva com sucesso"))
      );
    }

    buildSnackBarErro(BuildContext context){
      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao salvar. Verifique sua conexão."))
      );
    }

}

