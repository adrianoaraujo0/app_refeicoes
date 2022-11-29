import 'package:app_refeicoes/models/ingredient_meal.dart';
import 'package:app_refeicoes/models/step_meal.dart';

class Meal{
 final int? id;
 String? name;
 String? category;
 String? imgUrl;
 int? duration;
 String? complexity;
 String? cost;
 bool ingredientIsExpanded;
 bool stepIsExpanded;
 List<IngredientMeal> ingredientMeal;
 List<StepMeal> stepMeal;
 bool? favorite;

  Meal({
    this.id,
    this.name,
    this.cost,
    this.complexity,
    this.imgUrl,
    this.category,
    this.duration,
    this.ingredientIsExpanded = false,
    this.stepIsExpanded = false,
    required this.ingredientMeal,
    required this.stepMeal,
    this.favorite
  });

  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map["id"],
      name: map["name"],
      cost: map["cost"],
      complexity: map["complexity"],
      imgUrl: map["imgUrl"],
      duration: map["duration"],
      ingredientMeal: [],
      stepMeal: [],
      category: map["category"],
      favorite: map["favorite"] == 1 ? true : false,
    );
  }

  static fromMapList(List<Map<String, dynamic>> meals){
    return meals.map((e) => Meal.fromMap(e)).toList();
  }

   @override
     String toString() {
    return "id: $id, name: $name cost: $cost. complexity: $complexity, image: $imgUrl, duration: $duration, category: $category, favorite: $favorite";
  }
}