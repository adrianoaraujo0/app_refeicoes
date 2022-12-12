import 'dart:io';

import 'package:app_refeicoes/models/meal.dart';
import 'package:app_refeicoes/pages/my_meals/my_meal_controller.dart';
import 'package:flutter/material.dart';

class MyMealsPage extends StatefulWidget {

  const MyMealsPage({required this.id, super.key});
  final int id;

  @override
  State<MyMealsPage> createState() => _MyMealsPageState();
}

class _MyMealsPageState extends State<MyMealsPage> {
  MyMealsController myMealController = MyMealsController();

  @override
  void initState() {
    myMealController.initMyMealPage(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

  return StreamBuilder<Meal>(
    stream: myMealController.controllerMyMeal.stream,
    builder: (context, snapshotMeal) {
      if(snapshotMeal.data != null){
        return Scaffold(
            appBar: AppBar( backgroundColor: Colors.red),
            body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: FileImage(File(snapshotMeal.data!.imgUrl!)))
                          ),
                        ),
                        containerDetails(snapshotMeal.data!),
                        const SizedBox(height: 30),
                        const Divider(endIndent: 30, indent: 30),
                        SizedBox(
                          height: 25,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "INGREDIENTES",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red
                                )
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.fastfood_rounded),
                            ],
                          ),
                        ),
                        const Divider(endIndent: 30, indent: 30),
                        listViewIngredients(snapshotMeal.data!),
                        const SizedBox(height: 30),
                        const Divider(endIndent: 30, indent: 30),
                        SizedBox(
                          height: 25,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "PASSOS",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red
                                )
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.fastfood_rounded),
                            ],
                          ),
                        ),
                        const Divider(endIndent: 30, indent: 30),
                        listViewSteps(snapshotMeal.data!)
                      ]
                    ),
                  ),
                ),
            floatingActionButton: StreamBuilder<bool>(
              stream: myMealController.controllerFloatingActionButton.stream,
              initialData: true,
              builder: (context, snapshot) {
                if(snapshot.data == true){
                  return ElevatedButton(
                    child: const Text("Publicar"),
                    onPressed: () => myMealController.insertMealInFirebase(snapshotMeal.data!,  context , snapshotMeal.connectionState)
                  );
                }else{
                  return const CircularProgressIndicator();
                }
              }
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          );
        }else{
          return Container();
        }
      }
    );
  }

   Widget containerDetails(Meal meal){
    return Container(
      padding: const EdgeInsets.all(10),
      height: 120,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            meal.name!,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700, overflow: TextOverflow.fade)
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.access_time_rounded),
              const SizedBox(width: 5),
              Text("${myMealController.convertSecondsToMinutes(meal.duration)}min"),
              const SizedBox(width: 20),

              const Icon(Icons.monetization_on_outlined),
              const SizedBox(width: 5),
              Text("${meal.cost}"),
              const SizedBox(width: 20),
              
              const Icon(Icons.food_bank),
              const SizedBox(width: 5),
              Text("${meal.complexity}"),
            ],
          )
        ],
      ),
    );
  }

  Widget listViewIngredients(Meal meal){
    return  ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: meal.ingredientMeal!.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.arrow_right_sharp),
              const SizedBox(width: 10),
              Expanded(
                child: Text( 
                  meal.ingredientMeal![index],
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300)
                ),
              ),
            ],
          ),
        );  
      },
    );
  }

   Widget listViewSteps(Meal meal){
    return  ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: meal.stepMeal!.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Row(
              children: [
                Text("${index + 1}",
                style: const TextStyle(fontSize: 30, color: Colors.grey, fontWeight: FontWeight.w100)),
                const SizedBox(width: 15),
                Expanded(child: Text(meal.stepMeal![index], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300, overflow: TextOverflow.clip))),
                // if(meal.stepMeal[index]!= null) 
                // IconButton(
                //   icon: Icon(Icons.access_time, size: 40, color: Colors.amber[300]),
                //   onPressed: (){
                //     // Navigator.push(context, MaterialPageRoute(builder: (context) => StopwatchPage(seconds: meal!.mealSteps[index]["seconds"])));
                //   }
                // ),
              ]
            ),
        );  
      },
    );
  }
}