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
    id: 'm1',
    categories: ['c1', 'c2'],
    title: 'Spaghetti with Tomato Sauce',
    cost: Cost.cheap,
    complexity: Complexity.simple,
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg',
    duration: 20,
    ingredients: [
      '4 Tomatoes',
      '1 Tablespoon of Olive Oil',
      '1 Onion',
      '250g Spaghetti',
      'Spices',
      'Cheese (optional)'
    ],
    steps: [
      {
        "step": "Cut the tomatoes and the onion into small pieces.",
      },
      {
        "step": "Boil some water - add salt to it once it boils.",
      },
      {
        "step": "Put the spaghetti into the boiling water - they should be done in about 10 to 12 minutes.",
        "seconds": 12 
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
    isGlutenFree: false,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
    favorite: false
  ),
  Meal(
    id: 'm2',
    categories: ['c2'],
    title: 'Toast Hawaii',
    cost: Cost.cheap,
    complexity: Complexity.simple,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg',
    duration: 10,
    ingredients: [
      '1 Slice White Bread',
      '1 Slice Ham',
      '1 Slice Pineapple',
      '1-2 Slices of Cheese',
      'Butter'
    ],
    steps: [
      {
        "step" : "Grease one side of the white bread with butter for 20 minutes.",
        "seconds" : 1200
      },
      {
        "step" : "Layer ham, the pineapple and cheese on the white bread"
      },
      {
        "step" : "Bake the toast for round about 10 minutes in the oven at 200°C"
      }
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
    favorite: true
  ),
  Meal(
    id: 'm3',
    categories: ['c2', 'c3'],
    title: 'Classic Hamburger',
    cost: Cost.fair,
    complexity: Complexity.simple,
    imageUrl:
        'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg',
    duration: 45,
    ingredients: [
      '300g Cattle Hack',
      '1 Tomato',
      '1 Cucumber',
      '1 Onion',
      'Ketchup',
      '2 Burger Buns'
    ],
    steps: [
      {"step":"Form 2 patties"},
      {
      "step":"Fry the patties for c. 4 minutes on each sides",
      "seconds": 240
      },
      {"step":"Quickly fry the buns for c. 1 minute on each side"},
      {"step":"Bruch buns with ketchup'"},
      {"step":"Serve burger with tomato, cucumber and onion"},
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    favorite: true
  ),
  Meal(
    id: 'm4',
    categories: ['c4'],
    title: 'Wiener Schnitzel',
    cost: Cost.expensive,
    complexity: Complexity.medium,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/03/31/19/29/schnitzel-3279045_1280.jpg',
    duration: 60,
    ingredients: [
      '8 Veal Cutlets',
      '4 Eggs',
      '200g Bread Crumbs',
      '100g Flour',
      '300ml Butter',
      '100g Vegetable Oil',
      'Salt',
      'Lemon Slices'
    ],
    steps: [
      {"step":'Tenderize the veal to about 2–4mm, and salt on both sides.'},
      {"step":'On a flat plate, stir the eggs briefly with a fork.'},
      {"step":'Lightly coat the cutlets in flour then dip into the egg, and finally, coat in breadcrumbs.'},
      {"step":'Heat the butter and oil in a large pan (allow the fat to get very hot) and fry the schnitzels until golden brown on both sides.'},
      {"step":'Make sure to toss the pan regularly so that the schnitzels are surrounded by oil and the crumbing becomes "fluffy".'},
      {"step":'Remove, and drain on kitchen paper. Fry the parsley in the remaining oil and drain.'},
      {"step":'Place the schnitzels on awarmed plate and serve garnishedwith parsley and slices of lemon.'}
    ],
    isGlutenFree: false,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: false,
    favorite: false
  ),
  Meal(
    id: 'm5',
    categories: ['c2', 'c5', 'c10'],
    title: 'Salad with Smoked Salmon',
    cost: Cost.expensive,
    complexity: Complexity.simple,
    imageUrl:
        'https://cdn.pixabay.com/photo/2016/10/25/13/29/smoked-salmon-salad-1768890_1280.jpg',
    duration: 15,
    ingredients: [
      'Arugula',
      'Lamb\'s Lettuce',
      'Parsley',
      'Fennel',
      '200g Smoked Salmon',
      'Mustard',
      'Balsamic Vinegar',
      'Olive Oil',
      'Salt and Pepper',
    ],
    steps: [
      {"step":'Wash and cut salad and herbs'},
      {"step":'Dice the salmon'},
      {"step":'Process mustard, vinegar and olive oil into a dessing'},
      {"step":'Prepare the salad'},
      {"step":'Add salmon cubes and dressing'}
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: true,
    favorite: false
  ),
  Meal(
    id: 'm6',
    categories: ['c6', 'c10'],
    title: 'Delicious Orange Mousse',
    cost: Cost.cheap,
    complexity: Complexity.difficult,
    imageUrl:
        'https://cdn.pixabay.com/photo/2017/05/01/05/18/pastry-2274750_1280.jpg',
    duration: 240,
    ingredients: [
      '4 Sheets of Gelatine',
      '150ml Orange Juice',
      '80g Sugar',
      '300g Yoghurt',
      '200g Cream',
      'Orange Peel',
    ],
    steps: [
      {"step":'Dissolve gelatine in pot'},
      {"step":'Add orange juice and sugar'},
      {"step":'Take pot off the stove'},
      {"step":'Add 2 tablespoons of yoghurt'},
      {"step":'Stir gelatin under remaining yoghurt'},
      {"step":'Cool everything down in the refrigerator'},
      {"step":'Whip the cream and lift it under die orange mass'},
      {"step":'Cool down again for at least 4 hours'},
      {"step":'Serve with orange peel'},
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    favorite: false
  ),
  Meal(
    id: 'm7',
    categories: ['c7'],
    title: 'Pancakes',
    cost: Cost.cheap,
    complexity: Complexity.simple,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/07/10/21/23/pancake-3529653_1280.jpg',
    duration: 20,
    ingredients: [
      '1 1/2 Cups all-purpose Flour',
      '3 1/2 Teaspoons Baking Powder',
      '1 Teaspoon Salt',
      '1 Tablespoon White Sugar',
      '1 1/4 cups Milk',
      '1 Egg',
      '3 Tablespoons Butter, melted',
    ],
    steps: [
      {"step":'In a large bowl, sift together the flour, baking powder, salt and sugar.'},
      {"step":'Make a well in the center and pour in the milk, egg and melted butter; mix until smooth.'},
      {"step":'Heat a lightly oiled griddle or frying pan over medium high heat.'},
      {"step":'Pour or scoop the batter onto the griddle, using approximately 1/4 cup for each pancake. Brown on both sides and serve hot.'}
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    favorite: false
  ),
  Meal(
    id: 'm8',
    categories: ['c8'],
    title: 'Creamy Indian Chicken Curry',
    cost: Cost.fair,
    complexity: Complexity.medium,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/06/18/16/05/indian-food-3482749_1280.jpg',
    duration: 35,
    ingredients: [
      '4 Chicken Breasts',
      '1 Onion',
      '2 Cloves of Garlic',
      '1 Piece of Ginger',
      '4 Tablespoons Almonds',
      '1 Teaspoon Cayenne Pepper',
      '500ml Coconut Milk',
    ],
    steps: [
      {"step":'Slice and fry the chicken breast'},
      {"step":'Process onion, garlic and ginger into paste and sauté everything'},
      {"step":'Add spices and stir fry'},
      {
        "step":'Add chicken breast + 250ml of water and cook everything for 10 minutes',
        "seconds": 600
      },
      {"step":'Add coconut milk'},
      {"step":'Serve with rice'}
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: false,
    isLactoseFree: true,
    favorite: false
  ),
  Meal(
    id: 'm9',
    categories: ['c9'],
    title: 'Chocolate Souffle',
    cost: Cost.cheap,
    complexity: Complexity.difficult,
    imageUrl:
        'https://cdn.pixabay.com/photo/2014/08/07/21/07/souffle-412785_1280.jpg',
    duration: 45,
    ingredients: [
      '1 Teaspoon melted Butter',
      '2 Tablespoons white Sugar',
      '2 Ounces 70% dark Chocolate, broken into pieces',
      '1 Tablespoon Butter',
      '1 Tablespoon all-purpose Flour',
      '4 1/3 tablespoons cold Milk',
      '1 Pinch Salt',
      '1 Pinch Cayenne Pepper',
      '1 Large Egg Yolk',
      '2 Large Egg Whites',
      '1 Pinch Cream of Tartar',
      '1 Tablespoon white Sugar',
    ],
    steps: [
      {"step":'Preheat oven to 190°C. Line a rimmed baking sheet with parchment paper.'},
      {"step":'Brush bottom and sides of 2 ramekins lightly with 1 teaspoon melted butter; cover bottom and sides right up to the rim.'},
      {"step":'Add 1 tablespoon white sugar to ramekins. Rotate ramekins until sugar coats all surfaces.'},
      {"step":'Place chocolate pieces in a metal mixing bowl.'},
      {"step":'Place bowl over a pan of about 3 cups hot water over low heat.'},
      {"step":'Melt 1 tablespoon butter in a skillet over medium heat. Sprinkle in flour. Whisk until flour is incorporated into butter and mixture thickens.'},
      {"step":'Whisk in cold milk until mixture becomes smooth and thickens. Transfer mixture to bowl with melted chocolate.'},
      {"step":'Add salt and cayenne pepper. Mix together thoroughly. Add egg yolk and mix to combine.'},
      {"step":'Leave bowl above the hot (not simmering) water to keep chocolate warm while you whip the egg whites.'},
      {"step":'Place 2 egg whites in a mixing bowl; add cream of tartar. Whisk until mixture begins to thicken and a drizzle from the whisk stays on the surface about 1 second before disappearing into the mix.'},
      {"step":'Add 1/3 of sugar and whisk in. Whisk in a bit more sugar about 15 seconds.', "seconds": 15},
      {"step":'whisk in the rest of the sugar. Continue whisking until mixture is about as thick as shaving cream and holds soft peaks, 3 to 5 minutes.', "seconds": 300},
      {"step":'Transfer a little less than half of egg whites to chocolate.'},
      {"step": 'Mix until egg whites are thoroughly incorporated into the chocolate.'},
      {"step":'Add the rest of the egg whites; gently fold into the chocolate with a spatula, lifting from the bottom and folding over.'},
      {"step":'Stop mixing after the egg white disappears. Divide mixture between 2 prepared ramekins. Place ramekins on prepared baking sheet.'},
      {"step":'Bake in preheated oven until scuffles are puffed and have risen above the top of the rims, 12 to 15 minutes.', "seconds": 900},
    ],
    isGlutenFree: true,
    isVegan: false,
    isVegetarian: true,
    isLactoseFree: false,
    favorite: false
  ),
  Meal(
    id: 'm10',
    categories: ['c2', 'c5', 'c10'],
    title: 'Asparagus Salad with Cherry Tomatoes',
    cost: Cost.expensive,
    complexity: Complexity.simple,
    imageUrl:
        'https://cdn.pixabay.com/photo/2018/04/09/18/26/asparagus-3304997_1280.jpg',
    duration: 30,
    ingredients: [
      'White and Green Asparagus',
      '30g Pine Nuts',
      '300g Cherry Tomatoes',
      'Salad',
      'Salt, Pepper and Olive Oil'
    ],
    steps: [
      {"step":'Wash, peel and cut the asparagus'},
      {"step":'Cook in salted water'},
      {"step":'Salt and pepper the asparagus'},
      {"step":'Roast the pine nuts'},
      {"step":'Halve the tomatoes'},
      {"step":'Mix with asparagus, salad and dressing'},
      {"step":'Serve with Baguette'}
    ],
    isGlutenFree: true,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
    favorite: true
  ),
];
