// models/plan_category.dart
class PlanCategory {
  final String name;
  final int remainingPlans;
  final String actionText;

  PlanCategory({
    required this.name,
    required this.remainingPlans,
    this.actionText = 'Go to Plan →',
  });

  factory PlanCategory.fromJson(Map<String, dynamic> json) {
    return PlanCategory(
      name: json['name'],
      remainingPlans: json['remainingPlans'],
      actionText: json['actionText'] ?? 'Go to Plan →',
    );
  }
}