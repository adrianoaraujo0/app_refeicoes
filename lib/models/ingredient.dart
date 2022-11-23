class IngredientMeal{

  final int? id;
  final int? idMeal;
  final String? name;
  final bool isExpanded;

  IngredientMeal({this.id, required this.idMeal, required this.name, required this.isExpanded});

  factory IngredientMeal.fromMap(Map<String, dynamic> map){
    return IngredientMeal(
      id: map["idIngredient"],
      idMeal: map["idMeal"],
      name: map["name"],
      isExpanded: map["isExpanded"] == false
    );
  }

  static fromMapList(List<Map<String, dynamic>> ingredient){
    return ingredient.map((e) => IngredientMeal.fromMap(e)).toList();
  }

  @override
  String toString() {
    // TODO: implement toString
    return "id: $id, idMeal: $idMeal ,name: $name, isExpanded: $isExpanded";
  }

}