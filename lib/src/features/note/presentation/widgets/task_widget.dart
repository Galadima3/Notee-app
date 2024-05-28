// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TaskWidget extends StatefulWidget {
  final String taskTitle;
  final String taskDescription;
  bool? isTaskComplete;
  final VoidCallback onToggled;
  TaskWidget(
      {super.key,
      required this.taskTitle,
      required this.taskDescription,
      this.isTaskComplete,
      required this.onToggled});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  //bool checkBoxValue = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 350,
      child: CheckboxListTile(
          title: Text(
            widget.taskTitle,
            style: TextStyle(
              decoration: widget.isTaskComplete ?? false
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          subtitle: Text(widget.taskDescription,
              style: TextStyle(
                decoration: widget.isTaskComplete ?? false
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              )),
          controlAffinity: ListTileControlAffinity.leading,
          value: widget.isTaskComplete,
          onChanged: (bool? value) async {
            setState(() {
              widget.isTaskComplete = value;
            });

            widget.onToggled();
          }),
    );
  }
}