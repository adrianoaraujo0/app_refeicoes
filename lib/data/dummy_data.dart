import 'package:flutter/material.dart';
import '../../models/category.dart';
import '../../models/meal.dart';

const List<Category> dummyCategories = [
  Category(
    id: 'c1',
    name: 'Italiano',
  ),
  Category(
    id: 'c2',
    name: 'Rápido & Fácil',
  ),
  Category(
    id: 'c3',
    name: 'Hamburgers',
  ),
  Category(
    id: 'c4',
    name: 'Alemã',
  ),
  Category(
    id: 'c5',
    name: 'Leve & Saudável',
  ),
  Category(
    id: 'c6',
    name: 'Exótica',
  ),
  Category(
    id: 'c7',
    name: 'Café da Manhã',
  ),
  Category(
    id: 'c8',
    name: 'Asiática',
  ),
  Category(
    id: 'c9',
    name: 'Francesa',
  ),
  Category(
    id: 'c10',
    name: 'Verão',
  ),
];

const List<Meal> dummyMeals = [
  Meal(
    id: 1,
    uidMeal: "",
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
