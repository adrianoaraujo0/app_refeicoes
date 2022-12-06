import 'package:cloud_firestore/cloud_firestore.dart';

class MealController{

  
  double convertSecondsToMinutes(dynamic seconds){
    if(seconds >= 60){
      return seconds / 60;
    }
    return seconds.toDouble();
  }

  void changeFavorite(String id, bool favorite) async{
    FirebaseFirestore.instance.collection("meals").doc(id).update({"favorite" : !favorite});
    
  }


}