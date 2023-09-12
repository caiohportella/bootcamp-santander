import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskHiveModel extends HiveObject {
  @HiveField(0)
  String taskKey = "";

  @HiveField(1)
  String taskDescription = "";

  @HiveField(2)
  bool isTaskDone = false;

  TaskHiveModel();

  TaskHiveModel.create(this.taskDescription, this.isTaskDone);
}
