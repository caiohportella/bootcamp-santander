import 'package:hive/hive.dart';
import 'package:trilhaapp/model/task_model.dart';

class TaskHiveRepository {
  static late Box _taskBox;

  TaskHiveRepository._create();

  static Future<TaskHiveRepository> load() async {
    if (Hive.isBoxOpen("box_tasks")) {
      _taskBox = Hive.box("box_tasks");
    } else {
      _taskBox = await Hive.openBox("box_tasks");
    }

    return TaskHiveRepository._create();
  }

  save(TaskHiveModel tasks) {
    _taskBox.add(tasks);
  }

  update(TaskHiveModel tasks, bool isDone) {
    tasks.save();
  }

  delete(TaskHiveModel tasks) {
    tasks.delete();
  }

  List<TaskHiveModel> getData(bool isNotDone) {
    if (isNotDone) {
      return _taskBox.values
          .where((element) => element.isTaskDone == false)
          .cast<TaskHiveModel>()
          .toList();
    }

    return _taskBox.values.cast<TaskHiveModel>().toList();
  }
}
