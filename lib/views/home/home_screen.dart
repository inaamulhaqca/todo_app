import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/global_widgets/custom_app_bar.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/views/task/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.secondary,
      appBar: const CustomAppBar(title: 'To-Do List'),
      body: Consumer<TaskProvider>(
        builder: (context, provider, child) {
          if (provider.tasks.isEmpty) {
            return const Center(
              child: Text(
                'No tasks yet!',
                style: TextStyle(
                  color: ColorConstants.white,
                  fontSize: 20,
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              itemCount: provider.tasks.length,
              itemBuilder: (context, index) {
                final task = provider.tasks[index];
                return Dismissible(
                  key: Key(task.id),
                  onDismissed: (_) => provider.deleteTask(task),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: CheckboxListTile(
                      title: Text(
                        task.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      subtitle: task.description != null
                          ? Text(
                              task.description!,
                              style: const TextStyle(
                                  color: ColorConstants.secondary,
                                  fontSize: 16),
                            )
                          : null,
                      value: task.isCompleted,
                      onChanged: (_) => provider.toggleTaskCompletion(task),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                );
              },
            ),
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
