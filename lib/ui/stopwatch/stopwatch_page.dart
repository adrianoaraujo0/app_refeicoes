import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
class StopwatchPage extends StatelessWidget {

  final int seconds;
  StopwatchPage({required this.seconds, super.key});


  @override
  Widget build(BuildContext context) {

  final displayTime = StopWatchTimer.getDisplayTime(seconds); 
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red),
      body: Center(
        child: StreamBuilder<int>(
          stream: ,
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(),
                Text("${seconds}", style: TextStyle(fontSize: 60)),
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
            );
          }
        ),
      ),
    );
  }
}