import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool checkBoxValue = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: const [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1480429370139-e0132c086e2a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8bWFufGVufDB8fDB8fHww"),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text('Active', style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              
              ),),
            ),
            Row(
              children: [
                TaskWidget(
                    taskTitle: 'Code',
                    taskDescription: "Focus your efforts on Riverpod")
              ],
            )
          ],
        ),
      ),
    );
  }
}

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
  bool checkBoxValue = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 350,
      child: CheckboxListTile(
          title: Text(
            widget.taskTitle,
            style: TextStyle(
              decoration: checkBoxValue
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          subtitle: Text(widget.taskDescription,
              style: TextStyle(
                decoration: checkBoxValue
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              )),
          controlAffinity: ListTileControlAffinity.leading,
          value: checkBoxValue,
          onChanged: (bool? value) {
            setState(() {
              checkBoxValue = !checkBoxValue;
            });
          }),
    );
  }
}
