import 'package:hive/hive.dart';
import '../models/task.dart';

class TaskRepository {
  final Box<Task> _tasksBox = Hive.box<Task>('tasks');

  List<Task> getTasks() => _tasksBox.values.toList();

  Future<void> addTask(Task task) => _tasksBox.add(task);

  Future<void> updateTask(Task task) => task.save();

  Future<void> deleteTask(Task task) => task.delete();
}
