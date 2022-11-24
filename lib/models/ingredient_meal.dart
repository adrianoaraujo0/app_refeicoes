class IngredientMeal{

  final int? id;
  final int? mealId;
  final String? name;
  final bool isExpanded;

  IngredientMeal({this.id, required this.mealId, required this.name, required this.isExpanded});

  factory IngredientMeal.fromMap(Map<String, dynamic> map){
    return IngredientMeal(
      id: map["id"],
      mealId: map["mealId"],
      name: map["name"],
      isExpanded: map["isExpanded"] == false
    );
  }

  static fromMapList(List<Map<String, dynamic>> ingredient){
    return ingredient.map((e) => IngredientMeal.fromMap(e)).toList();
  }

  @override
  String toString() {
    return "id: $id, mealId: $mealId ,name: $name, isExpanded: $isExpanded";
  }

}