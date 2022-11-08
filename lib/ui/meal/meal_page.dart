import 'package:flutter/material.dart';
import '../../models/meal.dart';

class MealPage extends StatelessWidget {

  final Meal? meal;

  const MealPage({required  this.meal, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Image.network(meal!.imageUrl),
              Text(meal!.title, style: TextStyle(fontSize: 30),)
            ]
          ),
        ),
    );
  }
}