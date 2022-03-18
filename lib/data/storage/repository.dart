
import 'package:plantme/data/task.dart';
import 'package:plantme/data/provider.dart';



class TaskRepository {
  TaskProvider taskProvider;
  TaskRepository({this.taskProvider});

  List<Task> readTasks() => taskProvider.readTasks();
  void writeTasks(List<Task> tasks) => taskProvider.writeTasks(tasks);
}
