// lib/models/plan_model.dart
class PlanModel {
  final String id;
  final String title;
  final String category;
  final String description;
  final List<Task> tasks;
  final DateTime createdAt;
  final bool isCompleted;

  PlanModel({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.tasks,
    required this.createdAt,
    this.isCompleted = false,
  });
}

class Task {
  final String id;
  final String description;
  late final bool isCompleted;

  Task({
    required this.id,
    required this.description,
    this.isCompleted = false,
  });
}