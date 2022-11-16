import 'package:flutter/material.dart';
import '../../models/category.dart';
import '../../models/meal.dart';

const List<Category> dummyCategories = [
  Category(
    id: 'c1',
    title: 'Italiano',
    color: Colors.purple,
  ),
  Category(
    id: 'c2',
    title: 'Rápido & Fácil',
    color: Colors.red,
  ),
  Category(
    id: 'c3',
    title: 'Hamburgers',
    color: Colors.orange,
  ),
  Category(
    id: 'c4',
    title: 'Alemã',
    color: Colors.amber,
  ),
  Category(
    id: 'c5',
    title: 'Leve & Saudável',
    color: Colors.indigo,
  ),
  Category(
    id: 'c6',
    title: 'Exótica',
    color: Colors.green,
  ),
  Category(
    id: 'c7',
    title: 'Café da Manhã',
    color: Colors.lightBlue,
  ),
  Category(
    id: 'c8',
    title: 'Asiática',
    color: Colors.lightGreen,
  ),
  Category(
    id: 'c9',
    title: 'Francesa',
    color: Colors.pink,
  ),
  Category(
    id: 'c10',
    title: 'Verão',
    color: Colors.teal,
  ),
];

const List<Meal> dummyMeals = [
  Meal(
    id: 1,
    name: 'Spaghetti with Tomato Sauce',
    cost: "a",
    complexity: "simple",
    imgUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg',
    duration: 20,
    category: 'c1',
    mealIngredients: [
      '4 Tomatoes',
      '1 Tablespoon of Olive Oil',
      '1 Onion',
      '250g Spaghetti',
      'Spices',
      'Cheese (optional)'
    ],
    mealSteps: [
      {
        "step": "Cut the tomatoes and the onion into small pieces.",
      },
      {
        "step": "Boil some water - add salt to it once it boils.",
      },
      {
        "step": "Put the spaghetti into the boiling water - they should be done in about 10 to 12 minutes.",
        "seconds": 12.0
      },
      {
        "step": "In the meantime, heaten up some olive oil and add the cut onion.",
      },
      {
        "step": "After 2 minutes, add the tomato pieces, salt, pepper and your other spices.",
      },
      {
        "step": "The sauce will be done once the spaghetti are.",
      },
      {
        "step": "Feel free to add some cheese on top of the finished dish.",
      },
    ],
    glutenFree: false,
    vegan: true,
    vegetarian: true,
    lactoseFree: true,
    favorite: false
  ),
];
