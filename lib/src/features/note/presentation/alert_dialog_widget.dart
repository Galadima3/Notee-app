import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notee/src/features/note/data/note_service.dart';
import 'package:notee/src/features/note/domain/note.dart';

class TaskInputDialog extends StatefulWidget {
  const TaskInputDialog({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TaskInputDialogState createState() => _TaskInputDialogState();
}

class _TaskInputDialogState extends State<TaskInputDialog> {
  late String _task;
  late String _description;
  late DateTime _selectedTime;

  @override
  void initState() {
    super.initState();
    _task = '';
    _description = '';
    _selectedTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(labelText: 'Task'),
            onChanged: (value) {
              setState(() {
                _task = value;
              });
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Description'),
            onChanged: (value) {
              setState(() {
                _description = value;
              });
            },
          ),
          ListTile(
            title: Text('Select Time: $_selectedTime'),
            onTap: () {
              _selectTime(context);
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        Consumer(
          builder: (context, ref, child) => ElevatedButton(
            onPressed: () {
              _saveTask(context, ref);
            },
            child: const Text('Save'),
          ),
        ),
      ],
    );
  }
//TODO: fix the time button
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      // Convert TimeOfDay to DateTime
      final now = DateTime.now();
      final selectedDateTime = DateTime(
          now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);

      setState(() {
        // Update _selectedTime to DateTime
        _selectedTime = selectedDateTime;
      });
    }
  }

  void _saveTask(BuildContext context, WidgetRef ref) {
    if (_task.isNotEmpty) {
      // final Map<String, dynamic> taskData = {
      //   'task': _task,
      //   'description': _description,
      //   'time': _selectedTime,
      // };
      final taskData = Note(
          title: _task,
          description: _description,
          time: _selectedTime as DateTime,
          isTaskCompleted: true);
      ref.read(todoServiceProvider).createTODO(taskData);
      Navigator.pop(context, taskData);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a task.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
