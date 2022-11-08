import 'package:app_refeicoes/data/dummy_data.dart';
import 'package:app_refeicoes/models/category.dart';
import 'package:app_refeicoes/ui/meal/meal_page.dart';
import 'package:flutter/material.dart';

import '../../models/meal.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      height: 300,
      width: double.infinity,
      child: listViewbuilder()
    );
  }

  Widget listViewbuilder(){
   return ListView.builder(
      itemCount: dummyMeals.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        Meal meal = dummyMeals[index];
        Category category = dummyCategories[index];

        return InkWell(
          child: itemList(meal, category),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MealPage(meal: meal),)),
        );
      },
    );
  }

  Widget itemList(Meal meal, Category category){
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: 300,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(image: NetworkImage(meal.imageUrl), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 70,
              width: 250,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                borderRadius:  BorderRadius.vertical(bottom: Radius.circular(20)),
                color: Colors.black38, 
              ),
              child: Text(category.title, style: const TextStyle(color: Colors.white, fontSize: 16), textAlign: TextAlign.center),
            ),
          ]
        ),
      );
  }
}