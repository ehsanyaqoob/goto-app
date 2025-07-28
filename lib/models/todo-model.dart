// models/todo_model.dart
class Todo {
  final String id;
  final String title;
  final DateTime time;
  final String category;
  bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    required this.time,
    required this.category,
    this.isCompleted = false,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      time: DateTime.parse(json['time']),
      category: json['category'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'time': time.toIso8601String(),
      'category': category,
      'isCompleted': isCompleted,
    };
  }
}