import 'package:app_refeicoes/ui/stopwatch/stopwatch_controller.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
class StopwatchPage extends StatelessWidget {

  final double seconds;
  
  StopwatchPage({required this.seconds, super.key});

  StopwatchController stopwatchController = StopwatchController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(),
            Text(
              "${stopwatchController.hours(seconds).toStringAsFixed(0).padLeft(2, '0')}:${stopwatchController.minutes(seconds).toStringAsFixed(0)}:$seconds",
              style: const TextStyle(fontSize: 60)
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: const Icon(Icons.play_arrow)
                  ),
                ),
                  const SizedBox(width: 50),
                InkWell(
                  child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: const Icon(Icons.pause)
                  ),
                ),
              ],
            ),
          ],
        )
      )
    );
  }
}