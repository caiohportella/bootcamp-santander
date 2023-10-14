import 'package:flutter/material.dart';

class Task {
  final String _id = UniqueKey().toString();
  String taskDescription;
  bool isTaskDone = false;

  Task({required this.taskDescription, required this.isTaskDone});

  String get id => _id;
  String get description => taskDescription;
  set description(String description) => taskDescription = description;
  bool get isDone => isTaskDone;
  set isDone(bool isDone) => isTaskDone = isDone;
}
