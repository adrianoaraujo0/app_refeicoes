import 'package:app_refeicoes/data/dummy_data.dart';
import 'package:app_refeicoes/models/category.dart';
import 'package:app_refeicoes/pages/categories/categories_controller.dart';
import 'package:app_refeicoes/pages/meal/meal_page.dart';
import 'package:flutter/material.dart';
import '../../models/meal.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {

  CategoriesController categoriesController = CategoriesController();

  @override
  void initState() {
    categoriesController.initCategoriesPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
          height: 300,
          width: double.infinity,
          child: listViewCategories()
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text("Favorites", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: listViewFavorites(), 
        )
      ],
    );
  }

  Widget listViewCategories(){
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
        image: DecorationImage(image: NetworkImage(meal.imgUrl), fit: BoxFit.cover),
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

  Widget listViewFavorites(){
   return ListView.builder(
      shrinkWrap: true,
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
}