class Step{

  final int? id;
  final String? name;

  Step({this.id ,required this.name});

  factory Step.fromMap(Map<String, dynamic> map){
    return Step(
      id: map["idStep"],
      name: map["name"],
    );
  }

  static fromMapList(List<Map<String, dynamic>> step){
    return step.map((e) => Step.fromMap(e)).toList();
  }

  @override
  String toString() {
    // TODO: implement toString
    return "id: $id, name: $name";
  }
}