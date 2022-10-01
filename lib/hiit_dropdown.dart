import 'dart:async';
import 'hiit_timer.dart';
import 'hiit_type.dart';
import 'package:flutter/material.dart';

class HiitDropdown extends StatefulWidget {
  final HiitType hiitType;

  const HiitDropdown({super.key, required this.hiitType});

  @override
  State<StatefulWidget> createState() => _CountdownTimerState();
}

enum TimerType { notStarted, warmUp, effort, rest, coolDown }

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? countDown;
  bool isCountingDown = false;
  Duration? currentTimer;
  TimerType timerType = TimerType.notStarted;
  int doneReps = 0;

  void startHiit() {
    setState(() {
      currentTimer = widget.hiitType.warmUpTime;
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
            currentTimer = widget.hiitType.effortTime;
            timerType = TimerType.effort;
            break;
          case TimerType.effort:
            currentTimer = widget.hiitType.restTime;
            timerType = TimerType.rest;
            break;
          case TimerType.rest:
            if (doneReps < widget.hiitType.reps) {
              currentTimer = widget.hiitType.effortTime;
              timerType = TimerType.effort;
              doneReps++;
            } else {
              currentTimer = widget.hiitType.coolDownTime;
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
      Text("Name: ${widget.hiitType.name}"),
      Text(displayTimerType(timerType)),
      Text("${currentTimer ?? "No Timer"}"),
      Text("$doneReps out of ${widget.hiitType.reps}"),
      ElevatedButton(
        onPressed: currentTimer == null ? startHiit : null,
        child: const Text("Start"),
      )
    ]);
  }
}
