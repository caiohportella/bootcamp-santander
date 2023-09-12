import 'package:flutter/material.dart';
import 'package:trilhaapp/model/task_model.dart';
import 'package:trilhaapp/service/repositories/task_hive_repository.dart';
import 'package:trilhaapp/service/repositories/task_repository.dart';

class TaskHivePage extends StatefulWidget {
  const TaskHivePage({super.key});

  @override
  State<TaskHivePage> createState() => _TaskHivePageState();
}

class _TaskHivePageState extends State<TaskHivePage> {
  late TaskHiveRepository taskHiveRepository;

  var taskRepository = TaskRepository();
  var tasks = <TaskHiveModel>[];
  var descriptionController = TextEditingController();
  var isNotDone = false;

  void getTasks() async {
    taskHiveRepository = await TaskHiveRepository.load();

    tasks = taskHiveRepository.getData(isNotDone);
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
                          await taskHiveRepository.save(TaskHiveModel.create(
                              descriptionController.text, false));
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
                    var task = tasks[index];
                    return Dismissible(
                      onDismissed: (DismissDirection direction) async {
                        await taskHiveRepository.delete(task);
                        getTasks();
                      },
                      key: Key(task.taskKey),
                      child: ListTile(
                        title: Text(task.taskDescription),
                        trailing: Checkbox(
                          value: task.isTaskDone,
                          onChanged: (value) async {
                            task.isTaskDone = value!;
                            await taskHiveRepository.update(task, value);
                            setState(() {
                              getTasks();
                            });
                          },
                        ),
                        onLongPress: () {
                          taskHiveRepository.delete(task);
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
