import 'package:trilhaapp/model/back4app_tasks_model.dart';
import 'package:trilhaapp/service/repositories/back4app/back4app_custom_dio.dart';

class Back4AppTasksRepository {
  final _customDIO = Back4AppCustomDio();

  Back4AppTasksRepository();

  Future<Back4AppTasksModel> getTasks(bool isNotDone) async {
    var url = "/tasks";
    if (isNotDone) {
      url += "?where={\"isDone\":false}";
    } else {
      url += "?where={\"isDone\":true}";
    }
    var result = await _customDIO.dio.get(url);

    return Back4AppTasksModel.fromJson(result.data);
  }

  Future<void> createTask(TaskBack4App task) async {
    try {
      await _customDIO.dio.post("/tasks", data: task.toJsonEndpoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTask(TaskBack4App task) async {
    try {
      await _customDIO.dio.put("/tasks/${task.objectId}", data: task.toJsonEndpoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTask(String objID) async {
    try {
      await _customDIO.dio.delete("/tasks/$objID");
    } catch (e) {
      rethrow;
    }
  }
}
