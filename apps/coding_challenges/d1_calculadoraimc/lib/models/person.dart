import 'package:flutter/material.dart';

class Person {
  int id = UniqueKey().hashCode;
  late String personName;
  late double personWeight;
  late double personHeight;
  late double personBMI;
  late bool personHasGoodBMI;

  String get name => personName;
  set name(String name) => personName = name;

  double get weight => personWeight;
  set weight(double weight) => personWeight = weight;

  double get height => personHeight;
  set height(double height) => personHeight = height;

  double get bmi => personBMI;
  set bmi(double bmi) => personBMI = bmi;

  bool get hasGoodBMI => personHasGoodBMI;
  set hasGoodBMI(bool hasGoodBMI) => personHasGoodBMI = hasGoodBMI;

  Person({this.personName = '', this.personWeight = 0, this.personHeight = 0, this.personBMI = 0, this.personHasGoodBMI = false});
}
