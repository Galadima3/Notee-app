import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CompletedTaskWidget extends StatefulWidget {
  final String taskTitle;
  final String taskDescription;
  bool? isTaskComplete;
  final VoidCallback onToggled;
  CompletedTaskWidget(
      {super.key,
      required this.taskTitle,
      required this.taskDescription,
      this.isTaskComplete,
      required this.onToggled});

  @override
  State<CompletedTaskWidget> createState() => _CompletedTaskWidgetState();
}

class _CompletedTaskWidgetState extends State<CompletedTaskWidget> {
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
                  ? TextDecoration.none
                  : TextDecoration.lineThrough,
            ),
          ),
          subtitle: Text(widget.taskDescription,
              style: TextStyle(
                decoration: widget.isTaskComplete ?? false
                    ? TextDecoration.none
                    : TextDecoration.lineThrough,
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
