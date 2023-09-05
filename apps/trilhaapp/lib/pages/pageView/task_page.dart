import 'package:flutter/material.dart';
import 'package:trilhaapp/model/task.dart';
import 'package:trilhaapp/service/repositories/task_repository.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  var taskRepository = TaskRepository();
  var tasks = <Task>[];
  var descriptionController = TextEditingController();
  var isNotDone = false;

  void getTasks() async {
    tasks = await taskRepository.listTasks();

    if (isNotDone) {
      tasks = await taskRepository.listTasksUndone();
    } else {
      tasks = await taskRepository.listTasks();
    }
    setState(() {});
  }

  @override
  void initState() {
    getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          descriptionController.text = "";
          showDialog(
              context: context,
              builder: (BuildContext bc) {
                return AlertDialog(
                  title: const Text("Adicionar tarefa"),
                  content: TextField(
                    controller: descriptionController,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancelar")),
                    TextButton(
                        onPressed: () async {
                          await taskRepository.addTask(Task(
                              taskDescription: descriptionController.text,
                              isTaskDone: false));
                          Navigator.of(context).pop();
                          setState(() {
                            getTasks();
                          });
                        },
                        child: const Text("Adicionar")),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Mostrar não concluídos",
                        style: TextStyle(fontSize: 20)),
                    Switch(
                        value: isNotDone,
                        onChanged: (isNotDone) {
                          setState(() {
                            this.isNotDone = isNotDone;
                            getTasks();
                          });
                        }),
                  ],
                )),
            Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Dismissible(
                      onDismissed: (DismissDirection direction) async {
                        await taskRepository.removeTask(tasks[index]);
                        getTasks();
                      },
                      key: Key(tasks[index].id),
                      child: ListTile(
                        title: Text(tasks[index].description),
                        trailing: Checkbox(
                          value: tasks[index].isDone,
                          onChanged: (value) async {
                            await taskRepository.updateTask(
                                tasks[index].id, value!);
                            getTasks();
                          },
                        ),
                        onLongPress: () {
                          taskRepository.removeTask(tasks[index]);
                          getTasks();
                        },
                      ),
                    );
                  },
                  itemCount: tasks.length),
            ),
          ],
        ),
      ),
    );
  }
}
