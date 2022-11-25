class IngredientMeal{

  final int? id;
  final int? mealId;
  final String? name;

  IngredientMeal({this.id, required this.mealId, required this.name});

  factory IngredientMeal.fromMap(Map<String, dynamic> map){
    return IngredientMeal(
      id: map["id"],
      mealId: map["mealId"],
      name: map["name"],
    );
  }

  static fromMapList(List<Map<String, dynamic>> ingredient){
    return ingredient.map((e) => IngredientMeal.fromMap(e)).toList();
  }

  @override
  String toString() {
    return "id: $id, mealId: $mealId ,name: $name";
  }

}