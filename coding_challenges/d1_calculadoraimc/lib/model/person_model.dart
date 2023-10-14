import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'person_model.g.dart';

@HiveType(typeId: 0)
class PersonModel extends HiveObject {
  @HiveField(0)
  int personID = UniqueKey().hashCode;

  @HiveField(1)
  String personName = "";

  @HiveField(2)
  double personWeight = 0.0;

  @HiveField(3)
  double personHeight = 0.0;

  @HiveField(4)
  double personBMI = 0.0;

  @HiveField(5)
  bool personHasGoodBMI = false;

  PersonModel();

  PersonModel.create(this.personName, this.personWeight,
      this.personHeight, this.personBMI);

  // String get name => personName;
  // set name(String name) => personName = name;

  // double get weight => personWeight;
  // set weight(double weight) => personWeight = weight;

  // double get height => personHeight;
  // set height(double height) => personHeight = height;

  // double get bmi => personBMI;
  // set bmi(double bmi) => personBMI = bmi;

  // bool get hasGoodBMI => personHasGoodBMI;
  // set hasGoodBMI(bool hasGoodBMI) => personHasGoodBMI = hasGoodBMI;

  // PersonModel(
  //     {required this.personID,
  //     required this.personName,
  //     required this.personWeight,
  //     required this.personHeight,
  //     required this.personBMI,
  //     required this.personHasGoodBMI});
}
