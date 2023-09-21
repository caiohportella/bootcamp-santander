class Back4AppTasksModel {
  List<TaskBack4App> tasks = [];

  Back4AppTasksModel(this.tasks);

  Back4AppTasksModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      tasks = <TaskBack4App>[];
      json['results'].forEach((v) {
        tasks.add(TaskBack4App.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = tasks.map((v) => v.toJson()).toList();
      return data;
  }
}

class TaskBack4App {
  String objectId = "";
  String description = "";
  bool isDone = false;
  String createdAt = "";
  String updatedAt = "";

  TaskBack4App(
      this.objectId,
      this.description,
      this.isDone,
      this.createdAt,
      this.updatedAt);

  TaskBack4App.create(
      this.description,
      this.isDone);

  TaskBack4App.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    description = json['description'];
    isDone = json['isDone'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['description'] = description;
    data['isDone'] = isDone;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['isDone'] = isDone;
    return data;
  }
}
