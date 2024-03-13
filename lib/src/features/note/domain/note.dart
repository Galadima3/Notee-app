import 'package:isar/isar.dart';
part 'note.g.dart';

@collection
class Note {
  Note({this.description, this.isTaskCompleted, this.time, this.title});
  Id id = Isar.autoIncrement;
  String? title;
  String? description;
  bool? isTaskCompleted;
  DateTime? time;
}
