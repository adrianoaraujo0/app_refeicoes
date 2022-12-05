class MealController{

  
  double convertSecondsToMinutes(int seconds){
    if(seconds >= 60){
      return seconds / 60;
    }
    return seconds.toDouble();
  }


}