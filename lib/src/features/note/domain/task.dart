import 'package:isar/isar.dart';
part 'task.g.dart';

@collection
class Task {
  Task({
    required this.title,
    required this.description,
    this.isTaskCompleted = false,
    required this.time,
  });

  Id id = Isar.autoIncrement;
  final String title;
  final String description;
  bool isTaskCompleted;
  final DateTime time;

  Task copyWith({
    String? title,
    String? description,
    bool? isTaskCompleted,
    DateTime? time,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      isTaskCompleted: isTaskCompleted ?? this.isTaskCompleted,
      time: time ?? this.time,
    )..id = id; // Ensure the id is copied over
  }
}
