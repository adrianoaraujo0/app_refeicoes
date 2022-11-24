class StepMeal{

  final int? id;
  final int? mealId;
  final String? name;
  final bool isExpanded;

  StepMeal({this.id, required this.mealId ,required this.name, required this.isExpanded});

  factory StepMeal.fromMap(Map<String, dynamic> map){
    return StepMeal(
      id: map["idStep"],
      mealId: map["mealId"],
      name: map["name"],
      isExpanded: map["isExpanded"] == false
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