import 'package:trilhaapp/model/task_model_sqflite.dart';
import 'package:trilhaapp/service/repositories/sqflite/database.dart';

class TaskSQFLiteRepository {
  // ...
  Future<List<TaskSQFLiteModel>> getData(bool isNotDone) async {
    List<TaskSQFLiteModel> tasks = [];
    var db = await SQFLiteDatabase().getDatabase();
    var result = await db.rawQuery(
        'SELECT * FROM tasks WHERE isDone = ? ORDER BY id DESC',
        [isNotDone ? 0 : 1]);
    for (var item in result) {
      tasks.add(TaskSQFLiteModel(
        taskID: int.parse(item['id'].toString()),
        taskDescription: item['description'].toString(),
        taskStatus: item['isDone'] == 1 ? true : false,
      ));
    }

    return tasks;
  }

  Future<void> insertData(TaskSQFLiteModel task) async {
    var db = await SQFLiteDatabase().getDatabase();
    await db.rawInsert('INSERT INTO tasks(description, isDone) VALUES(?, ?)',
        [task.taskDescription, task.taskStatus ? 1 : 0]);
  }

  Future<void> updateData(TaskSQFLiteModel task) async {
    var db = await SQFLiteDatabase().getDatabase();
    await db.rawUpdate(
        'UPDATE tasks SET description = ?, isDone = ? WHERE id = ?',
        [task.taskDescription, task.taskStatus ? 1 : 0, task.taskID]);
  }

  Future<void> deleteData(TaskSQFLiteModel task) async {
    var db = await SQFLiteDatabase().getDatabase();
    await db.rawDelete('DELETE FROM tasks WHERE id = ?', [task.taskID]);
  }
}
