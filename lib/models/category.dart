import 'package:flutter/material.dart';

class Category {

  final String id;
  final String name;

  const Category({
    required this.id,
    required this.name,
  });

  //transformar um mapa num objetoo
  factory Category.fromMap(Map<String, dynamic> map){
    return Category(
      id: map["idCategory"],
      name: map["name"]);
  }

  //transformar uma lista de mapa num objeto
  static fromMapList(List<Map<String, dynamic>> categories){
    return categories.map((e) => Category.fromMap(e)).toList();
  }

}