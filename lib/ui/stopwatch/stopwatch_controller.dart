import 'dart:async';

class  StopwatchController{

  StreamController  stopwatch = StreamController();

  double hours(double seconds){
    final double hours = seconds/3600;

    if(hours < 1){return 00;}
    
    return hours;
  }

 double minutes(double seconds){

    final double minutes = seconds/60;

    if(minutes < 1){return 00;}
    
    return minutes;

  }

}