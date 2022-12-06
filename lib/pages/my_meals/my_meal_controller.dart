import 'dart:io';

import 'package:app_refeicoes/models/meal.dart';
import 'package:app_refeicoes/pages/my_meals/my_meal_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class MyMealsController{

  BehaviorSubject<Meal> controllerMyMeal = BehaviorSubject();

  MyMealRepository myMealRepository = MyMealRepository();

  Future<void> initMyMealPage(Meal meal) async{
    await myMealRepository.initDb();
    meal.ingredientMeal = await myMealRepository.findAllIngredients(meal.id!);
    meal.stepMeal = await myMealRepository.findAllSteps(meal.id!);
    controllerMyMeal.sink.add(meal);
  }

  void insertMealInFirebase(Meal meal, BuildContext context) async{

  //ADICIONAR A IMAGEM NO FIREBASE
  UploadTask uploadTask = FirebaseStorage.instance.ref(meal.id.toString()).putFile(File(meal.imgUrl!));
  // PEGA A URL DA IMAGEM NO FIREBASE
  // await uploadTask.snapshot.ref.getDownloadURL()

  await FirebaseFirestore.instance.collection("meals")
  .doc(meal.id.toString())
  .set(
      {
        "imgUrl" : await uploadTask.snapshot.ref.getDownloadURL(), 
        "name" : meal.name,
        "category" : meal.category,
        "duration" : meal.duration,
        "complexity" : meal.complexity,
        "cost" : meal.cost,
        "ingredients" : {"teste": 1},
        "steps" : {"B": 1, "A": 2, "C": 3},
        "favorite" : false
      },
    ).whenComplete(() {
      buildSnackBar(context);
    });

    //  FirebaseFirestore.instance.collection("meals").doc("1").set({});

  }

    buildSnackBar(BuildContext context){
      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Receita salva com sucesso"))
      );
    }

}

