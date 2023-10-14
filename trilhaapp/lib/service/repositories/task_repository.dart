import 'package:trilhaapp/model/task.dart';

class TaskRepository {
  final List<Task> _tasks = [];

  Future<void> addTask(Task task) async {
    await Future.delayed(const Duration(microseconds: 200));
    _tasks.add(task);
  }

  Future<void> removeTask(Task task) async {
    await Future.delayed(const Duration(microseconds: 200));
    _tasks.remove(task);
  }

  Future<void> updateTask(String id, bool done) async {
    await Future.delayed(const Duration(microseconds: 200));
    final task = _tasks.firstWhere((element) => element.id == id);
    task.isDone = done;
  }

  Future<List<Task>> listTasks() async {
    await Future.delayed(const Duration(microseconds: 200));

    return _tasks;
  }

  Future<List<Task>> listTasksUndone() async {
    await Future.delayed(const Duration(microseconds: 200));

    return _tasks.where((element) => !element.isDone).toList();
  }
}