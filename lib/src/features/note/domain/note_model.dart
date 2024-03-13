class NoteModel {
  final String title;
  final String description;
  final bool isTaskCompleted;
  final DateTime time;

  NoteModel({
    required this.title,
    required this.description,
    this.isTaskCompleted = false,
    required this.time,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      isTaskCompleted: json['isTaskCompleted'] ?? false,
      time: json['time'] != null ? DateTime.parse(json['time']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isTaskCompleted': isTaskCompleted,
      'time': time.toIso8601String(),
    };
  }

  NoteModel copyWith({
    String? title,
    String? description,
    bool? isTaskCompleted,
    DateTime? time,
  }) {
    return NoteModel(
      title: title ?? this.title,
      description: description ?? this.description,
      isTaskCompleted: isTaskCompleted ?? this.isTaskCompleted,
      time: time ?? this.time,
    );
  }
}
