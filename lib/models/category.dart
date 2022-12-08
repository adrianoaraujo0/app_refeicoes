class Category {

  final String name;
  final String image;

  const Category({
    required this.name,
    required this.image,
  });

  //transformar um mapa num objetoo
  factory Category.fromMap(Map<String, dynamic> map){
    return Category(
      name: map["name"],
      image: map["image"]);
  }

  //transformar uma lista de mapa num objeto
  static fromMapList(List<Map<String, dynamic>> categories){
    return categories.map((e) => Category.fromMap(e)).toList();
  }

}