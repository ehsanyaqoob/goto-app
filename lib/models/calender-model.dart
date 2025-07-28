class CalendarEvent {
  final String title;
  final DateTime date;
  final String? description;
  final bool isCompleted;

  CalendarEvent({
    required this.title,
    required this.date,
    this.description,
    this.isCompleted = false,
  });

  CalendarEvent copyWith({
    String? title,
    DateTime? date,
    String? description,
    bool? isCompleted,
  }) {
    return CalendarEvent(
      title: title ?? this.title,
      date: date ?? this.date,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class WorkoutReport {
  final int calories;
  final double fat;
  final double carbs;
  final double protein;

  WorkoutReport({
    required this.calories,
    required this.fat,
    required this.carbs,
    required this.protein,
  });
}

class Activity {
  final String name;
  final String duration;

  Activity({required this.name, required this.duration});
}