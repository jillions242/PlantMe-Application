import 'dart:convert';
import 'package:get/get.dart';
import 'package:plantme/data/task.dart';
import 'package:plantme/data/storage/services.dart';
import 'package:plantme/data/utils/keys.dart';




class TaskProvider {
  StorageService storage = Get.find<StorageService>();

  List<Task> readTasks() {
    var tasks = <Task>[];
    jsonDecode(storage.read(taskKey).toString())
        .forEach((e) => tasks.add(Task.fromJson(e)));
    return tasks;
  }

  void writeTasks(List<Task> tasks) {
    storage.write(taskKey, jsonEncode(tasks));
  }
}
