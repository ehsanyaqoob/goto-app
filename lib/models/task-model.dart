import 'package:hive/hive.dart';

part 'task-model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  bool isPinned;

  @HiveField(4)
  bool isChecklist;

  @HiveField(5)
  final int colorIndex;

  @HiveField(6)
  final bool isList;

  @HiveField(7)
  bool isCompleted;

  NoteModel({
    required this.title,
    required this.description,
    required this.createdAt,
    this.isPinned = false,
    this.isChecklist = false,
    this.colorIndex = 0,
    this.isList = false,
    this.isCompleted = false,
  });
}