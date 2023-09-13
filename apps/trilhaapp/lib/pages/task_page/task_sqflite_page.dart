import 'package:flutter/material.dart';
import 'package:trilhaapp/model/task_model.dart';
import 'package:trilhaapp/model/task_model_sqflite.dart';
import 'package:trilhaapp/service/repositories/sqflite/task_sqflite_repository.dart';
import 'package:trilhaapp/service/repositories/task_hive_repository.dart';
import 'package:trilhaapp/service/repositories/task_repository.dart';

class TaskSQFLitePage extends StatefulWidget {
  const TaskSQFLitePage({super.key});

  @override
  State<TaskSQFLitePage> createState() => _TaskSQFLitePageState();
}

class _TaskSQFLitePageState extends State<TaskSQFLitePage> {
  TaskSQFLiteRepository taskSQFLiteRepository = TaskSQFLiteRepository();

  var taskRepository = TaskRepository();
  var tasks = <TaskSQFLiteModel>[];
  var descriptionController = TextEditingController();
  var isNotDone = false;

  void getTasks() async {
    tasks = await taskSQFLiteRepository.getData(isNotDone);
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
                          await taskSQFLiteRepository.insertData(TaskSQFLiteModel(
                            taskID: 0,
                            taskDescription: descriptionController.text,
                            taskStatus: false,
                          ));
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
                        await taskSQFLiteRepository.deleteData(task);
                        getTasks();
                      },
                      key: Key(task.taskID.toString()),
                      child: ListTile(
                        title: Text(task.taskDescription),
                        trailing: Checkbox(
                          value: task.taskStatus,
                          onChanged: (value) async {
                            task.taskStatus = value!;
                            await taskSQFLiteRepository.updateData(task);
                            setState(() {
                              getTasks();
                            });
                          },
                        ),
                        onLongPress: () {
                          taskSQFLiteRepository.deleteData(task);
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
