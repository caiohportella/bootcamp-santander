import 'package:flutter/material.dart';
import 'package:trilhaapp/model/back4app_tasks_model.dart';
import 'package:trilhaapp/service/repositories/back4app/back4app_tasks_repository.dart';

class TaskHTTPPage extends StatefulWidget {
  const TaskHTTPPage({super.key});

  @override
  State<TaskHTTPPage> createState() => _TaskHTTPPageState();
}

class _TaskHTTPPageState extends State<TaskHTTPPage> {
  Back4AppTasksRepository tasksRepository = Back4AppTasksRepository();

  var tasks = Back4AppTasksModel([]);
  var descriptionController = TextEditingController();
  var isNotDone = false;
  var loading = false;

  void getTasks() async {
    setState(() {
      loading = true;
    });
    tasks = await tasksRepository.getTasks(isNotDone);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tarefas")),
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
                          await tasksRepository.createTask(TaskBack4App.create(
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
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
              ),
            ),
            loading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: tasks.tasks.length,
                      itemBuilder: (context, index) {
                        var task = tasks.tasks[index];
                        return Dismissible(
                          onDismissed: (DismissDirection direction) async {
                            await tasksRepository.deleteTask(task.objectId);
                            getTasks();
                          },
                          key: Key(task.description),
                          child: ListTile(
                            title: Text(task.description),
                            trailing: Checkbox(
                              value: task.isDone,
                              onChanged: (value) async {
                                task.isDone = value!;
                                await tasksRepository.updateTask(task);
                                setState(() {
                                  getTasks();
                                });
                              },
                            ),
                            onLongPress: () {
                              tasksRepository.deleteTask(task.objectId);
                              getTasks();
                            },
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
