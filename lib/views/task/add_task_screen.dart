import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/global_widgets/custom_app_bar.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/providers/task_provider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.secondary,
      appBar: const CustomAppBar(title: 'Add Task'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title*',
                  fillColor: Colors.white,
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorConstants.secondary),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                validator: (value) => value!.isEmpty ? 'Required' : null,
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  fillColor: Colors.white,
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorConstants.secondary),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final task = Task(
                      id: DateTime.now().toString(),
                      title: _titleController.text,
                      description: _descriptionController.text.isEmpty
                          ? null
                          : _descriptionController.text,
                    );
                    Provider.of<TaskProvider>(context, listen: false)
                        .addTask(task);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
