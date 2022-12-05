import 'package:app_refeicoes/models/meal.dart';
import 'package:app_refeicoes/pages/list_meal/list_meal_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/subjects.dart';

class ListMealController{

  ListMealRepository listMealRepository = ListMealRepository();
  BehaviorSubject<List<Meal>> controllerListMeal = BehaviorSubject<List<Meal>>();

  Future<void> initPage(String nameCategory) async{
    await listMealRepository.initDb();
    await listCategories(nameCategory);
  }

  Future<void> listCategories(String category) async{
    List<Meal> listMeal = await listMealRepository.findMealListByCategory(category);
    controllerListMeal.sink.add(listMeal);
  }

  void changeFavorite(String id, bool favorite) async{
    FirebaseFirestore.instance.collection("meals").doc(id).update({"favorite" : !favorite});
    
  }

}