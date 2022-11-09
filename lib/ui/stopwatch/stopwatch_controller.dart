import 'dart:async';

class  StopwatchController{

  StreamController  stopwatch = StreamController();


  onExecute(int time){
    for(int i = 0; i<= time; i++){
      return i;
    }
  }

}