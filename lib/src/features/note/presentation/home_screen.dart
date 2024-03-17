import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notee/src/features/note/data/note_service.dart';
import 'package:notee/src/features/note/presentation/alert_dialog_widget.dart';

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
        // leading: const CircleAvatar(
        //   radius: 25,
        //   backgroundImage: NetworkImage(
        //       "https://images.unsplash.com/photo-1480429370139-e0132c086e2a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8bWFufGVufDB8fDB8fHww"),
        // ),
        actions: const [
          Badge(
            label: Text('4'),
            backgroundColor: Colors.red,
            child: Icon(
              Icons.check_box,
              color: Colors.blue,
            ),
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
              child: StreamBuilder(
            stream: isarService.listenTODO(),
            builder: (context, snapshot) {
             
              return snapshot.hasData
                  ? ListView.builder(
                    itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        
                         var todo = snapshot.data?[index];
                        return TaskWidget(
                            taskTitle: todo?.title ?? 'Test ',
                            taskDescription: todo?.description ?? 'TEst DEscription',
                            isTaskComplete: todo?.isTaskCompleted ?? false,
                            );

                      },
                    )
                  : SizedBox(
                    height: 250,
                    width: 250,
                    child: SvgPicture.asset('assets/images/blank.svg'));
            },
          ))
      
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 25),
          //   child: Text(
          //     'Active',
          //     style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          //   ),
          // ),
          // Row(
          //   children: [
          //     TaskWidget(
          //         taskTitle: 'Code',
          //         taskDescription: "Focus your efforts on Riverpod")
          //   ],
          // )
        ],
      ),
    );
  }
}

class TaskWidget extends StatefulWidget {
  final String taskTitle;
  final String taskDescription;
  final bool isTaskComplete;
  const TaskWidget({
    super.key,
    required this.taskTitle,
    required this.taskDescription, required this.isTaskComplete,
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
