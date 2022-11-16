enum Complexity {
    simple,
    medium,
    difficult,
}

enum Cost {
  cheap,
  fair,
  expensive,
}

class Meal{
  final int id;
  final String category;
  final String name;
  final String imgUrl;
  final List<String> mealIngredients;
  final List<Map<String, dynamic>> mealSteps;
  final int duration;
  final bool glutenFree;
  final bool lactoseFree;
  final bool vegan;
  final bool vegetarian;
  final String complexity;
  final String cost;
  final bool favorite;

  const Meal({
    required this.id,
    required this.category,
    required this.name,
    required this.imgUrl,
    required this.mealIngredients,
    required this.mealSteps,
    required this.duration,
    required this.glutenFree,
    required this.lactoseFree,
    required this.vegan,
    required this.vegetarian,
    required this.complexity,
    required this.cost,
    required this.favorite
  });

  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map["idMeal"],
      name: map["name"],
      cost: map["cost"],
      complexity: map["complexity"],
      imgUrl: map["img"],
      duration: map["duration"],
      category: map["category"],
      mealIngredients: map["mealIngredient"],
      mealSteps: map["mealSteps"],
      glutenFree: map["glutenFree"],
      lactoseFree: map["lactoseFree"],
      vegan: map["vegan"],
      vegetarian: map["vegetarian"],
      favorite: map["favorite"],
    );
  }

  static fromMapList(List<Map<String, dynamic>> meals){
    return meals.map((e) => Meal.fromMap(e)).toList();
  }




}