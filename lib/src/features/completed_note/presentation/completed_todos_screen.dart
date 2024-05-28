import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notee/src/features/completed_note/presentation/completed_task_widget.dart';
import 'package:notee/src/features/completed_note/presentation/completed_todo_notifier.dart';
import 'package:notee/src/features/note/data/note_service.dart';


class CompletedTodosScreen extends StatelessWidget {
  const CompletedTodosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Tasks'),
        centerTitle: true,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final todos = ref.watch(todoStateNotifierProvider);
          return Center(
            child: todos.isEmpty
                ? const Text("No Completed tasks for now")
                : ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (BuildContext context, int index) {
                      var rex = todos[index];
                      
                      return CompletedTaskWidget(
                        taskTitle: rex.title,
                        taskDescription: rex.description,
                        isTaskComplete: !rex.isTaskCompleted,
                        onToggled: () async {
                          ref
                              .read(todoStateNotifierProvider.notifier)
                              .removeCompletedTask(rex);
                          ref.read(todoServiceProvider).createTODO(rex);
                        },
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
