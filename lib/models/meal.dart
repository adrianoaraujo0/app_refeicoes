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
  final String uidMeal;
  final String category;
  final String name;
  final String imgUrl;
  final int duration;
  final String complexity;
  final String cost;
  final bool? favorite;

  const Meal({
    required this.id,
    required this.uidMeal,
    required this.category,
    required this.name,
    required this.imgUrl,
    required this.duration,
    required this.complexity,
    required this.cost,
    this.favorite
  });

  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map["idMeal"],
      uidMeal: map["uidMeal"],
      name: map["name"],
      cost: map["cost"],
      complexity: map["complexity"],
      imgUrl: map["img"],
      duration: map["duration"],
      category: map["category"],
      favorite: map["favorite"] == 1 ? true : false,
    );
  }

  static fromMapList(List<Map<String, dynamic>> meals){
    return meals.map((e) => Meal.fromMap(e)).toList();
  }

   String toString() {
    // TODO: implement toString
    return "id: $id, name: $name, uid: ${uidMeal.toString()}, cost: $cost. complexity: $complexity, image: $imgUrl, duration: $duration, category: $category, favorite: $favorite";
  }
}