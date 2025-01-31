import 'package:flutter/material.dart';
import '../repositories/task_repository.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  final TaskRepository _repository = TaskRepository();
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  TaskProvider() {
    loadTasks();
  }

  void loadTasks() {
    _tasks = _repository.getTasks();
    notifyListeners();
  }

  void addTask(Task task) async {
    await _repository.addTask(task);
    loadTasks();
  }

  void toggleTaskCompletion(Task task) {
    task.isCompleted = !task.isCompleted;
    _repository.updateTask(task);
    notifyListeners();
  }

  void deleteTask(Task task) async {
    await _repository.deleteTask(task);
    loadTasks();
  }
}
