import 'package:isar/isar.dart';
part 'note.g.dart';

@collection
class Note {
  Note({required this.description, required this.isTaskCompleted, required this.time, required this.title});
  Id id = Isar.autoIncrement;
  final String title;
  final String description;
  bool isTaskCompleted = false;
  final DateTime time;
}
