import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goto/constants/Theme/app_colors.dart';
import 'package:goto/controllers/task_controller.dart';
import 'package:goto/widgets/custom_text.dart';

class AnalyticsView extends StatefulWidget {
  AnalyticsView({super.key});

  @override
  State<AnalyticsView> createState() => _AnalyticsViewState();
}

class _AnalyticsViewState extends State<AnalyticsView> {
  final TaskController controller = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.scaffoldBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.analytics, color: AppColors.primary),
            SizedBox(width: 8),
            CustomText(
              text: "Analytics",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          final allTasks = controller.tasks;
          final completed = allTasks.where((e) => e.isDone).toList();
          final pending = allTasks.where((e) => !e.isDone).toList();
          final total = allTasks.length;

          double percent = total == 0 ? 0 : (completed.length / total * 100);

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Scrollbar(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 16),

                  _buildIconSummary(Icons.assessment, "Total Tasks", total.toString()),
                  const SizedBox(height: 8),

                  _buildIconSummary(Icons.check_circle, "Completed Tasks", completed.length.toString()),
                  const SizedBox(height: 8),

                  _buildIconSummary(Icons.access_time, "Pending Tasks", pending.length.toString()),
                  const SizedBox(height: 8),

                  _buildIconSummary(Icons.trending_up, "Completion Rate", "${percent.toStringAsFixed(1)}%"),

                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Icon(Icons.calendar_view_day, size: 20, color: Colors.blue),
                      SizedBox(width: 8),
                      CustomText(
                        text: "Productivity By Day",
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildGroupedTasksByDay(allTasks),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildIconSummary(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          Icon(icon, size: 24, color:AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: CustomText(
              text: label,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: CustomText(
              key: ValueKey(value),
              text: value,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupedTasksByDay(List tasks) {
    final Map<String, int> dayWiseCount = {};

    for (var task in tasks) {
      final date = task.date as DateTime;
      final day =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      dayWiseCount[day] = (dayWiseCount[day] ?? 0) + 1;
    }

    final entries = dayWiseCount.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key)); // descending order

    return Column(
      children: entries.map((e) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
              const SizedBox(width: 10),
              Expanded(
                child: CustomText(
                  text: e.key,
                  fontSize: 15,
                ),
              ),
              CustomText(
                text: "${e.value} Task(s)",
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}