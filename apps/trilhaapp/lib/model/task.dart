import 'package:flutter/material.dart';

class Task {
  final String _id = UniqueKey().toString();
  String description = "";
  bool isDone = false;

  Task({required this.description, required this.isDone});

  String getId() => _id.toString();
  String getDescription() => description;
  void setDescription(String description) => this.description = description;
  bool getIsDone() => isDone;
  void setIsDone(bool isDone) => this.isDone = isDone;
}
