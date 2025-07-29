import 'package:flutter/cupertino.dart';
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
    return CupertinoPageScaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.scaffoldBackgroundColor,
        middle: CustomText(
          text: "📈 Analytics",
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: SafeArea(
        child: Obx(() {
          final allTasks = controller.tasks;
          final completed = allTasks.where((e) => e.isDone).toList();
          final pending = allTasks.where((e) => !e.isDone).toList();
          final total = allTasks.length;

          double percent = total == 0 ? 0 : (completed.length / total * 100);

          return Padding(
            padding: const EdgeInsets.all(20),
            child: CupertinoScrollbar(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 16),

                  _buildEmojiSummary("📊", "Total Tasks", total.toString()),
                  const SizedBox(height: 8),

                  _buildEmojiSummary("✅", "Completed Tasks", completed.length.toString()),
                  const SizedBox(height: 8),

                  _buildEmojiSummary("🕗", "Pending Tasks", pending.length.toString()),
                  const SizedBox(height: 8),

                  _buildEmojiSummary("📌", "Completion Rate", "${percent.toStringAsFixed(1)}%"),

                  const SizedBox(height: 24),
                  CustomText(
                    text: "📅 Productivity By Day",
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
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

  Widget _buildEmojiSummary(String emoji, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: CupertinoColors.systemGrey6,
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
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
            color: CupertinoColors.secondarySystemGroupedBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(CupertinoIcons.calendar,
                  size: 18, color: CupertinoColors.systemGrey),
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
