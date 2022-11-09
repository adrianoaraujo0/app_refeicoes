import 'package:flutter/material.dart';
class StopwatchPage extends StatelessWidget {

  final int seconds;
  const StopwatchPage({required this.seconds, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(),
            Text("00:00:00", style: TextStyle(fontSize: 60)),
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
        ),
      ),
    );
  }
}