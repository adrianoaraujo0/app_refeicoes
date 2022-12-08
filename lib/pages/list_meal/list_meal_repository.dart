import 'dart:developer';

import 'package:app_refeicoes/db/database_provider.dart';
import 'package:app_refeicoes/models/meal.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ListMealRepository{

   late final Database _database;

  Future<void> initDb() async{
    _database = await DBProvider.db.database;
  }

  // Future<List<Meal>> findAllMeals() async {
  //   List<Map<String, dynamic>> mealMap = await _database.rawQuery("SELECT * FROM meal");
    
  //   return Meal.fromMapList(mealMap);
  // }

  //  Future<List<Meal>> findMealListByCategory(String category) async{
  //   List<Map<String, dynamic>> listMeal = await _database.rawQuery("SELECT * FROM meal WHERE category = '$category'");
  //   return  Meal.fromMapList(listMeal);
  // }
}