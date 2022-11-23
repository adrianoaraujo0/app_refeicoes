import 'package:app_refeicoes/models/ingredient.dart';
import 'package:app_refeicoes/models/meal.dart';
import 'package:app_refeicoes/models/step_meal.dart';

class FormRegistration{

  final Meal? meal;
  final IngredientMeal? ingredient;
  final StepMeal? step;

  FormRegistration({this.meal,this.ingredient,this.step});
}