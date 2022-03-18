import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantme/data/task.dart';
import 'package:plantme/data/storage/repository.dart';



class HomeController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final editCtrl = TextEditingController();
  final tabIndex = 0.obs;
  final chipIndex = 0.obs;
  final deleting = false.obs;
  final task = Rx<Task>(null);
  final tasks = <Task>[].obs;
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;
  TaskRepository taskRepository;
  HomeController({ this.taskRepository});

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }
  @override
  void onClose() {
    editCtrl.dispose();
    super.onClose();
  }

  void setchipIndex(int value) {
    chipIndex.value = value;
  }

  void setTabIndex(int value) {
    tabIndex.value = value;
  }

  void setDeleting(bool value) {
    deleting.value = value;
  }

  void selectTask(Task select) {
    task.value = select;
  }

  void selectTodos(List<dynamic> select) {
    doingTodos.clear();
    doneTodos.clear();
    for (int i = 0; i < select.length; i++) {
      var todo = select[i];
      var status = todo['done'];
      if (status == true) {
        doneTodos.add(todo);
      } else {
        doingTodos.add(todo);
      }
    }
  }

  bool addTask(Task task) {
    // only check task name & icon & color, ignore the todos
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  bool updateTask(Task task, String title) {
    var todos = task.todos ?? [];
    if (containTodo(todos, title)) {
      return false;
    }
    var todo = {"title": title, "done": false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldIdx = tasks.indexOf(task);
    tasks[oldIdx] = newTask;
    tasks.refresh();
    return true;
  }

  bool containTodo(List<dynamic> todos, String title) {
    return todos.any((element) => element['title'] == title);
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  bool addTodo(String title) {
    var todo = {'title': title, 'done': false};
    if (doingTodos
        .any((element) => mapEquals<String, dynamic>(todo, element))) {
      return false;
    }
    if (doneTodos.any((element) =>
        mapEquals<String, dynamic>({'title': title, 'done': true}, element))) {
      return false;
    }
    doingTodos.add(todo);
    return true;
  }

  void updateTodos(Task task) {
    var newTodos = <Map<String, dynamic>>[];
    newTodos.addAll([
      ...doingTodos,
      ...doneTodos,
    ]);
    var newTask = task.copyWith(todos: newTodos);
    int oldIdx = tasks.indexOf(task);
    tasks[oldIdx] = newTask;
    tasks.refresh();
  }

  void doneTodo(String title) {
    int index = doingTodos.indexWhere((element) =>
        mapEquals<String, dynamic>({'title': title, 'done': false}, element));
    doingTodos.removeAt(index);
    doneTodos.add({'title': title, 'done': true});
    doingTodos.refresh();
    doneTodos.refresh();
  }

  void deleteDoneTodo(String title) {
    int index = doneTodos.indexWhere((element) =>
        mapEquals<String, dynamic>({'title': title, 'done': true}, element));
    doneTodos.removeAt(index);
    doneTodos.refresh();
  }

  bool isTodosEmpty(Task task) {
    return task.todos == null || task.todos.isEmpty;
  }

  int getDoneTodo(Task task) {
    var res = 0;
    for (int i = 0; i < task.todos.length; i++) {
      if (task.todos[i]['done'] == true) {
        res += 1;
      }
    }
    return res;
  }

  int getTotalTask() {
    var res = 0;
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].todos != null) {
        res += tasks[i].todos.length;
      }
    }
    return res;
  }

  int getTotalDoneTask() {
    var res = 0;
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].todos != null) {
        for (int j = 0; j < tasks[i].todos.length; j++) {
          if (tasks[i].todos[j]['done'] == true) {
            res += 1;
          }
        }
      }
    }
    return res;
  }
}
