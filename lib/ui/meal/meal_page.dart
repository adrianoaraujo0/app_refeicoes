import 'package:app_refeicoes/ui/stopwatch/stopwatch_page.dart';
import 'package:flutter/material.dart';
import '../../models/meal.dart';

class MealPage extends StatelessWidget {

  final Meal? meal;

  const MealPage({required  this.meal, super.key});

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
              Image.network(meal!.imageUrl),
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
              listViewIngredients(),
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
              listViewSteps()
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
            meal!.title,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700, overflow: TextOverflow.fade)
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.access_time_rounded),
              const SizedBox(width: 5),
              Text("${meal!.duration}min"),
              const SizedBox(width: 20),

              const Icon(Icons.monetization_on_outlined),
              const SizedBox(width: 5),
              Text(meal!.costText),
              const SizedBox(width: 20),
              
              const Icon(Icons.food_bank),
              const SizedBox(width: 5),
              Text(meal!.complexityText)
            ],
          )
        ],
      ),
    );
  }

  Widget listViewIngredients(){
    return  ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: meal!.ingredients.length,
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
                  meal!.ingredients[index],
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300)
                ),
              ),
            ],
          ),
        );  
      },
    );
  }

   Widget listViewSteps(){
    return  ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: meal!.steps.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Row(
              children: [
                Text("${index + 1}",
                style: const TextStyle(fontSize: 30, color: Colors.grey, fontWeight: FontWeight.w100)),
                const SizedBox(width: 15),
                Expanded(child: Text(meal!.steps[index]["step"], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300, overflow: TextOverflow.clip))),
                if(meal!.steps[index]["seconds"] != null) 
                IconButton(
                  icon: Icon(Icons.access_time, size: 40, color: Colors.amber[300]),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => StopwatchPage(seconds: meal!.steps[index]["seconds"])));
                  }
                ),
              ]
            ),
        );  
      },
    );
  }

}