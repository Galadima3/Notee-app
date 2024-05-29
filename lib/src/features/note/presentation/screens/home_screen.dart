import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notee/src/features/completed_note/presentation/completed_todo_notifier.dart';
import 'package:notee/src/features/completed_note/presentation/completed_todos_screen.dart';
import 'package:notee/src/features/note/data/note_service.dart';
import 'package:notee/src/features/note/domain/task.dart';
import 'package:notee/src/features/note/presentation/screens/edit_task_screen.dart';
import 'package:notee/src/features/note/presentation/widgets/alert_dialog_widget.dart';
import 'package:notee/src/features/note/presentation/widgets/dismissable_theming.dart';
import 'package:notee/src/features/note/presentation/widgets/task_widget.dart';

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
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final numbers = ref.watch(todoStateNotifierProvider);
              return GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CompletedTodosScreen(),
                )),
                child: Badge(
                  label: Text(numbers.length.toString()),
                  backgroundColor: Colors.red,
                  child: const Icon(
                    Icons.check_box,
                    color: Colors.blue,
                  ),
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return const TaskInputDialog();
            },
          );
        },
        child: const Icon(Icons.edit_note),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final todos = ref.watch(allNotesProvider);
                return todos.when(
                  data: (data) => ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final todo = data[index];
                      return Dismissible(
                        key: Key(todo.id.toString()),
                        background: slideRightBackground(),
                        secondaryBackground: slideLeftBackground(),
                        confirmDismiss: (direction) =>
                            _confirmDismiss(direction, todo, ref),
                        child: TaskWidget(
                          taskTitle: todo.title,
                          taskDescription: todo.description,
                        ),
                      );
                    },
                  ),
                  error: (error, stackTrace) =>
                      Center(child: Text('Error: $error')),
                  loading: () => const Center(
                      child: CircularProgressIndicator(color: Colors.blue)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> _confirmDismiss(
      DismissDirection direction, Task todo, WidgetRef ref) async {
    if (direction == DismissDirection.endToStart) {
      final bool? res = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text("Do you want to mark this task as complete?"),
            actions: <Widget>[
              TextButton(
                child:
                    const Text("Cancel", style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: const Text("Sure", style: TextStyle(color: Colors.red)),
                onPressed: () {
                  ref.read(todoServiceProvider).deleteTODO(todo.id);
                  ref
                      .read(todoStateNotifierProvider.notifier)
                      .addCompletedTask(todo);
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      );
      return res ?? false;
    } else {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return EditTaskScreen(task: todo);
        },
      ));
    }
    return null;
  }
}
