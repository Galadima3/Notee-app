// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TaskWidget extends StatefulWidget {
  final String taskTitle;
  final String taskDescription;

  const TaskWidget({
    super.key,
    required this.taskTitle,
    required this.taskDescription,
  });

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        minTileHeight: 70,
        
        tileColor: Colors.grey.shade200,
        
        title: Text(
          widget.taskTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          widget.taskDescription,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
