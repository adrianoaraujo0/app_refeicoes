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
        child: Column(
          children: [
            Image.network(meal!.imageUrl),
            Container(
              padding: const EdgeInsets.all(10),
              height: 90,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal!.title,
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700)
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
            ),
            Container(
              height: 250,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Ingredients",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red
                        )
                      ),
                      Icon(Icons.fastfood_rounded),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Flexible(
                    child: ListView.builder(
                      itemCount: meal!.ingredients.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            children: [
                              Text( 
                                meal!.ingredients[index],
                                style: const TextStyle(overflow: TextOverflow.clip, fontSize: 20)
                              ),
                            ],
                          ),
                        );  
                      },
                    ),
                  )
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}