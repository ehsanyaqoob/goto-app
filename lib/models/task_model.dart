import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  bool isDone;

  @HiveField(4)
  final String emoji;

  @HiveField(5)
  final String taskType; // 'task', 'list', 'plan', 'reminder'

  @HiveField(6)
  final List<String>? subTasks; // For list type

  TaskModel({
    required this.title,
    this.description = '',
    required this.date,
    this.isDone = false,
    this.emoji = '📝',
    this.taskType = 'task',
    this.subTasks,
  });

  String get key => super.key.toString();
}