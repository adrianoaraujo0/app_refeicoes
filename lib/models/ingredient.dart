class Ingredient{

  final int? id;
  final String uidMeal;
  final String name;

  Ingredient({this.id, required this.uidMeal, required this.name});

  factory Ingredient.fromMap(Map<String, dynamic> map){
    return Ingredient(
      id: map["idIngredient"],
      uidMeal: map["uidMeal"],
      name: map["name"]
    );
  }

  static fromMapList(List<Map<String, dynamic>> ingredient){
    return ingredient.map((e) => Ingredient.fromMap(e)).toList();
  }

  @override
  String toString() {
    // TODO: implement toString
    return "id: $id, name: $name, uid: $uidMeal";
  }

}