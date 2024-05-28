import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notee/src/features/completed_note/presentation/completed_todo_notifier.dart';
import 'package:notee/src/features/completed_note/presentation/completed_todos_screen.dart';
import 'package:notee/src/features/note/data/note_service.dart';
import 'package:notee/src/features/note/presentation/widgets/alert_dialog_widget.dart';
import 'package:notee/src/features/note/presentation/todo_state_notifier.dart';
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
    final isarService = TODOService();
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
            child: Consumer(builder: (context, ref, child) {
               final todos = ref.watch(allNotesProvider);
                return todos.when(
                  data: (data) => ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final todo = data[index];
                      return TaskWidget(
                        taskTitle: todo.title,
                        taskDescription: todo.description,
                        isTaskComplete: todo.isTaskCompleted,
                        onToggled: () async {
                          ref.read(todoServiceProvider).deleteTODO(todo.id);
                          ref.read(todoStateNotifierProvider.notifier).addCompletedTask(todo);
                        },
                      );
                    },
                  ),
                  error: (error, stackTrace) => Text('Error: $error'),
                  loading: () => const Center(child: CircularProgressIndicator()));
            },),
          //     child: StreamBuilder(
          //   stream: isarService.listenTODO(),
          //   builder: (context, snapshot) {
          //     return snapshot.hasData
          //         ? ListView.builder(
          //             itemCount: snapshot.data?.length,
          //             itemBuilder: (context, index) {
          //               var todo = snapshot.data?[index];
          //               return TaskWidget(
          //                 taskTitle: todo!.title,
          //                 taskDescription: todo.description,
          //                 isTaskComplete: todo.isTaskCompleted,
          //                 onToggled: () async {
          //                   ref.read(todoServiceProvider).deleteTODO(todo.id);
          //                   ref
          //                       .read(todoStateNotifierProvider.notifier)
          //                       .addCompletedTask(todo);
          //                 },
          //               );
          //             },
          //           )
          //         : SizedBox(
          //             height: 250,
          //             width: 250,
          //             child: SvgPicture.asset('assets/images/blank.svg'));
          //   },
          // ))
          )
        ],
      ),
    );
  }
}
