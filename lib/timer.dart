import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  State<StatefulWidget> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Duration time = Duration(seconds: 30);
  Timer? countDown;
  bool isCountingDown = false;

  void startCountDown() {
    setState(() {
      isCountingDown = true;
      countDown = Timer.periodic(const Duration(milliseconds: 1), (timer) {
        performCountDown();
      });
    });
  }

  void stopCountDown() {
    setState(() {
      isCountingDown = false;
      countDown!.cancel();
    });
  }

  void resetCountDown() {
    stopCountDown();
    setState(() {
      time = Duration(seconds: 30);
    });
  }

  void performCountDown() {
    setState(() {
      time = Duration(milliseconds: time.inMilliseconds - 1);

      if (time.inMilliseconds <= 0) {
        countDown!.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('$time'),
      ElevatedButton(
          onPressed: isCountingDown ? null : startCountDown,
          child: const Text("Play")),
      ElevatedButton(
          onPressed: isCountingDown ? stopCountDown : null,
          child: const Text("Pause")),
      ElevatedButton(onPressed: resetCountDown, child: const Text("Reset")),
    ]);
  }
}
