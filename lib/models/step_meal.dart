class StepMeal{

  final int? id;
  final int? mealId;
  final String? name;

  StepMeal({this.id, required this.mealId ,required this.name});

  factory StepMeal.fromMap(Map<String, dynamic> map){
    return StepMeal(
      id: map["idStep"],
      mealId: map["mealId"],
      name: map["name"],
    );
  }

  static fromMapList(List<Map<String, dynamic>> step){
    return step.map((e) => StepMeal.fromMap(e)).toList();
  }

  @override
  String toString() {
    return "id: $id, name: $name, isExpanded";
  }
}