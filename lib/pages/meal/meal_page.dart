import 'package:app_refeicoes/pages/meal/meal_controller.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MealPage extends StatelessWidget {

  MealPage({required this.meal ,super.key});
  MealController mealController = MealController();
  final Map<String, dynamic>  meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(meal["imgUrl"]),
              containerDetails(),
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
              listViewIngredients(meal["ingredients"]),
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
              listViewSteps(meal["steps"])
            ]
          ),
        ),
      ),
    );
  }

   Widget containerDetails(){
    return Container(
      padding: const EdgeInsets.all(10),
      height: 120,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            meal["name"],
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500, overflow: TextOverflow.fade)
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.access_time_rounded),
              const SizedBox(width: 5),
              Text("${mealController.convertSecondsToMinutes(meal["duration"]).toStringAsPrecision(1)} min"),
              const SizedBox(width: 20),

              const Icon(Icons.monetization_on_outlined),
              const SizedBox(width: 5),
              Text("${meal["cost"]}"),
              const SizedBox(width: 20),
              
              const Icon(Icons.food_bank),
              const SizedBox(width: 5),
              Text("${meal["complexity"]}"),
            ],
          )
        ],
      ),
    );
  }

  Widget listViewIngredients(List<dynamic> ingredientsMeal){
    print(ingredientsMeal.length);
    return  ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: ingredientsMeal.length,
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
                  ingredientsMeal[index],
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300)
                ),
              ),
            ],
          ),
        );  
      },
    );
  }

   Widget listViewSteps(List<dynamic> stepsMeal){
    return  ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: stepsMeal.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Row(
              children: [
                Text("${index + 1}",
                style: const TextStyle(fontSize: 30, color: Colors.grey, fontWeight: FontWeight.w100)),
                const SizedBox(width: 15),
                Expanded(child: Text(stepsMeal[index], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300, overflow: TextOverflow.clip))),
                // if(meal!.mealSteps[index]["seconds"] != null) 
                // IconButton(
                //   icon: Icon(Icons.access_time, size: 40, color: Colors.amber[300]),
                //   onPressed: (){
                //     Navigator.push(context, MaterialPageRoute(builder: (context) => StopwatchPage(seconds: meal!.mealSteps[index]["seconds"])));
                //   }
                // ),
              ]
            ),
        );  
      },
    );
  }

}