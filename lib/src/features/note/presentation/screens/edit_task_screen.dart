import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:notee/src/features/note/data/note_service.dart';
import 'package:notee/src/features/note/domain/task.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;
  const EditTaskScreen({super.key, required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController titleController;
  late TextEditingController bodyController;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the task's title and body
    titleController = TextEditingController(text: widget.task.title);
    bodyController = TextEditingController(text: widget.task.description);
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(
                labelText: 'Body',
              ),
            ),
            const SizedBox(height: 16),
            Consumer(
              builder: (context, ref, child) {
                return ElevatedButton(
                  onPressed: () {
                    final updatedTask = widget.task.copyWith(
                        title: titleController.text,
                        description: bodyController.text,
                        time: DateTime.now());
                    ref.read(todoServiceProvider).updateTODO(updatedTask);

                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
