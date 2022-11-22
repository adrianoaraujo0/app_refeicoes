import 'package:app_refeicoes/models/ingredient.dart';
import 'package:app_refeicoes/models/meal.dart';
import 'package:app_refeicoes/models/step.dart';

class FormRegistration{

  final Meal? meal;
  final Ingredient? ingredient;
  final Step? step;

  FormRegistration({this.meal,this.ingredient,this.step});
}