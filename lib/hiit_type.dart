import 'package:flutter/material.dart';

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

List<HiitType> hiitTypes = [
  HiitType(
      name: "Basic",
      warmUpTime: Duration(seconds: 1),
      coolDownTime: Duration(minutes: 5),
      effortTime: Duration(minutes: 5),
      restTime: Duration(minutes: 5),
      reps: 5),
  HiitType(
      name: "Another One",
      warmUpTime: Duration(minutes: 5),
      coolDownTime: Duration(minutes: 5),
      effortTime: Duration(minutes: 5),
      restTime: Duration(minutes: 5),
      reps: 5),
];

List<DropdownMenuItem<HiitType>> dropdownHiitTypes = hiitTypes
    .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
    .toList();
