import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  State<StatefulWidget> createState() => _CountdownTimerState();
}

class HiitType {
  String name;
  Duration warmUpTime;
  Duration coolDownTime;
  Duration effortTime;
  Duration restTime;
  int reps;

  HiitType(
      {required this.name,
      required this.warmUpTime,
      required this.coolDownTime,
      required this.effortTime,
      required this.restTime,
      required this.reps});
}

enum TimerType { notStarted, warmUp, effort, rest, coolDown }

class _CountdownTimerState extends State<CountdownTimer> {
  HiitType hiitType = HiitType(
      name: "test",
      warmUpTime: const Duration(seconds: 5),
      coolDownTime: const Duration(seconds: 5),
      effortTime: const Duration(seconds: 5),
      restTime: const Duration(seconds: 5),
      reps: 5);
  Timer? countDown;
  bool isCountingDown = false;
  Duration? currentTimer;
  TimerType timerType = TimerType.notStarted;
  int doneReps = 0;

  void startHiit() {
    setState(() {
      currentTimer = hiitType.warmUpTime;
      timerType = TimerType.warmUp;
      countDown = Timer.periodic(const Duration(milliseconds: 1), (timer) {
        performHiit();
      });
    });
  }

  void performHiit() {
    setState(() {
      currentTimer = Duration(milliseconds: currentTimer!.inMilliseconds - 1);

      if (currentTimer!.inMilliseconds <= 0) {
        countDown!.cancel();
        switch (timerType) {
          case TimerType.warmUp:
            currentTimer = hiitType.effortTime;
            timerType = TimerType.effort;
            break;
          case TimerType.effort:
            currentTimer = hiitType.restTime;
            timerType = TimerType.rest;
            break;
          case TimerType.rest:
            if (doneReps < hiitType.reps) {
              currentTimer = hiitType.effortTime;
              timerType = TimerType.effort;
              doneReps++;
            } else {
              currentTimer = hiitType.coolDownTime;
              timerType = TimerType.coolDown;
            }
            break;
          case TimerType.coolDown:
            break;
          case TimerType.notStarted:
            break;
        }
        countDown = Timer.periodic(const Duration(milliseconds: 1), (timer) {
          performHiit();
        });
      }
    });
  }

  // void startCountDown() {
  //   setState(() {
  //     isCountingDown = true;
  //     countDown = Timer.periodic(const Duration(milliseconds: 1), (timer) {
  //       performCountDown();
  //     });
  //   });
  // }

  // void stopCountDown() {
  //   setState(() {
  //     isCountingDown = false;
  //     countDown!.cancel();
  //   });
  // }

  // void resetCountDown() {
  //   stopCountDown();
  //   setState(() {
  //     time = Duration(seconds: 30);
  //   });
  // }

  // void performCountDown() {
  //   setState(() {
  //     time = Duration(milliseconds: time.inMilliseconds - 1);

  //     if (time.inMilliseconds <= 0) {
  //       countDown!.cancel();
  //     }
  //   });
  // }

  String displayTimerType(TimerType aTimerType) {
    switch (aTimerType) {
      case TimerType.warmUp:
        return "Warm Up";
      case TimerType.coolDown:
        return "Cooldown";
      case TimerType.effort:
        return "Effort";
      case TimerType.rest:
        return "Rest";
      case TimerType.notStarted:
        return "Timer not started";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text("Name: ${hiitType.name}"),
      Text(displayTimerType(timerType)),
      Text("{$currentTimer}"),
      Text("$doneReps out of ${hiitType.reps}"),
      ElevatedButton(
        onPressed: currentTimer == null ? startHiit : null,
        child: const Text("Start"),
      )
    ]);
  }
}
