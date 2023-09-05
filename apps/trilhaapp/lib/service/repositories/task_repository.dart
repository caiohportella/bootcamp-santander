import 'package:trilhaapp/model/task.dart';

class TaskRepository {
  final List<Task> _tasks = [];

  void addTask(Task task) async {
    await Future.delayed(const Duration(seconds: 2));
    _tasks.add(task);
  }

  void removeTask(Task task) async {
    await Future.delayed(const Duration(seconds: 2));
    _tasks.remove(task);
  }

  void updateTask(String id, bool done) async {
    await Future.delayed(const Duration(seconds: 2));
    final task = _tasks.firstWhere((element) => element.getId() == id);
    task.setIsDone(done);
  }

  Future<List<Task>> listTasks() async {
    await Future.delayed(const Duration(seconds: 2));

    return _tasks;
  }
}