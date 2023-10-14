class TaskSQFLiteModel {
  int taskID = 0;
  String taskDescription = "";
  bool taskStatus = false;

  int get id => taskID;
  String get description => taskDescription;
  bool get status => taskStatus;

  set id(int id) => id = taskID;
  set description(String description) => description = taskDescription;
  set status(bool status) => status = taskStatus;

  TaskSQFLiteModel({required this.taskID, required this.taskDescription, required this.taskStatus});
}