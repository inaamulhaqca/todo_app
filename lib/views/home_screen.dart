import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/views/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 38, 67),
      appBar: AppBar(
        title: const Text('To-Do List'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Consumer<TaskProvider>(
        builder: (context, provider, child) {
          if (provider.tasks.isEmpty) {
            return const Center(child: Text('No tasks yet!'));
          }
          return ListView.builder(
            itemCount: provider.tasks.length,
            itemBuilder: (context, index) {
              final task = provider.tasks[index];
              return Dismissible(
                key: Key(task.id),
                onDismissed: (_) => provider.deleteTask(task),
                background: Container(color: Colors.red),
                child: CheckboxListTile(
                  title: Text(
                    task.title,
                    style: task.isCompleted
                        ? const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.white,
                          )
                        : null,
                  ),
                  subtitle:
                      task.description != null ? Text(task.description!) : null,
                  value: task.isCompleted,
                  onChanged: (_) => provider.toggleTaskCompletion(task),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddTaskScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
