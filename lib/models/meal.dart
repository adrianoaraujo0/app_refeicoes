import 'package:objectbox/objectbox.dart';

@Entity()
class Meal{

 int? id;
 String? name;
 String? category;
 String? imgUrl;
 double? duration;
 String? complexity;
 String? cost;
 List<String>? ingredientMeal;
 List<String>? stepMeal;

 @Transient()
 bool ingredientIsExpanded = false;
 @Transient()
 bool stepIsExpanded = false;

 Meal({this.name, this.category, this.imgUrl, this.duration, this.complexity, this.cost, this.ingredientMeal, this.stepMeal});

}