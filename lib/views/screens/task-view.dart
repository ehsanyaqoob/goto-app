import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:goto/constants/Theme/app_colors.dart';
import 'package:goto/controllers/add-task-model.dart';
import 'package:goto/controllers/task_controller.dart';
import 'package:goto/extension/media_query_extensions.dart';
import 'package:goto/widgets/animated-entry/summary-dialog.dart';
import 'package:goto/widgets/animated-entry/week-calendar.dart';
import 'package:goto/widgets/custom_text.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class TaskView extends StatefulWidget {
  TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> with TickerProviderStateMixin {
  final TaskController controller = Get.put(TaskController());
  int _lastCompletedCount = 0;

  @override
  void initState() {
    super.initState();
    controller.completedTasksStream.listen((count) {
      if (count == 5 && count > _lastCompletedCount) {
        _showSuccessDialog();
      }
      _lastCompletedCount = count;
    });
  }

  void _showSuccessDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) => SuccessSummaryDialog(),
    );
  }

  // Calculate workout metrics based on completed tasks
  Map<String, dynamic> getWorkoutMetrics() {
    final completedTasks = controller.tasks.where((task) => task.isDone).length;
    final totalTasks = controller.tasks.length;
    final completionRatio = totalTasks > 0 ? completedTasks / totalTasks : 0;
    
    return {
      'calories': (300 * completionRatio).round(),
      'fat': (10 * completionRatio).toStringAsFixed(1),
      'carbs': (25 * completionRatio).round(),
      'protein': (30 * completionRatio).toStringAsFixed(1),
    };
  }

  void _showAddTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>  AddTaskBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle: CustomText(
          text: "Plan Details", 
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
        trailing: Icon(
          Icons.more_horiz_rounded,
          color: AppColors.primary,
          size: 24,
        ),
        border: null,
        backgroundColor: AppColors.scaffoldBackgroundColor),
      child: SafeArea(
        child: Stack(
          children: [
            Obx(() {
              final metrics = getWorkoutMetrics();
              final selectedDate = controller.selectedDate.value;
              final tasks = controller.tasks;
              
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        // Custom Week Calendar
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                height: 10.h,
                                width: double.infinity,
                                child: HorizontalWeekCalendar(
                                  selectedDate: selectedDate,
                                  onDateSelected: controller.updateSelectedDate,
                                  primaryColor: AppColors.primary,
                                  daySize: 40,
                                  dayMargin: 4,
                                  dayTextStyle: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  selectedDayTextStyle: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  weekdayTextStyle: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  selectedItemPadding: 8,
                                ),
                              ),
                            ),
                          ),
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 6,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                              text: "Workout Report",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildWorkoutItem(
                                    "🔥", 
                                    "${metrics['calories']}kKal", 
                                    "calories burn"
                                  ),
                                  _buildWorkoutItem(
                                    "🏃", 
                                    "${metrics['fat']}g", 
                                    "Fat burned"
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildWorkoutItem(
                                    "💪", 
                                    "${metrics['carbs']}g", 
                                    "Carbs burned"
                                  ),
                                  _buildWorkoutItem(
                                    "⏱️", 
                                    "${metrics['protein']}g", 
                                    "Protein gained"
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        10.0.height,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 6,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Activity",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (tasks.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          "😴 No tasks for this day.",
                          style: TextStyle(
                            fontSize: 16,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                      ),
                    )
                  else
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final task = tasks[index];
                        return TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: 1),
                          duration: Duration(milliseconds: 300 + (index * 50)),
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.translate(
                                offset: Offset(0, (1 - value) * 20),
                                child: child,
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            child: Dismissible(
                              key: Key(task.key),
                              direction: DismissDirection.endToStart,
                              onDismissed: (_) => controller.deleteTask(index),
                              background: Container(
                                decoration: BoxDecoration(
                                  color: CupertinoColors.systemRed,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: const Icon(
                                  CupertinoIcons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: task.isDone
                                      ? CupertinoColors.systemGrey5
                                      : CupertinoColors.secondarySystemGroupedBackground,
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 6,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () => controller.toggleTaskCompletion(index),
                                      child: Icon(
                                        task.isDone
                                            ? CupertinoIcons.check_mark_circled_solid
                                            : CupertinoIcons.circle,
                                        color: task.isDone
                                            ? CupertinoColors.activeGreen
                                            : CupertinoColors.inactiveGray,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            task.title,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              decoration: task.isDone
                                                  ? TextDecoration.lineThrough
                                                  : null,
                                              color: task.isDone
                                                  ? CupertinoColors.systemGrey
                                                  : CupertinoColors.label,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          if (task.description.isNotEmpty)
                                            Text(
                                              task.description,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: task.isDone
                                                    ? CupertinoColors.systemGrey3
                                                    : CupertinoColors.systemGrey,
                                              ),
                                            ),
                                          const SizedBox(height: 2),
                                          Text(
                                            "🕒 ${DateFormat.jm().format(task.date)}",
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: task.isDone
                                                  ? CupertinoColors.systemGrey3
                                                  : CupertinoColors.systemGrey2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }, childCount: tasks.length),
                    ),
                  // Add padding at the bottom for the FAB
                  SliverPadding(
                    padding: EdgeInsets.only(bottom: 80),
                  ),
                ],
              );
            }),
            // Positioned FAB at the bottom center
            Positioned(
              bottom: 30,
              left: 290,
              right: 0,
              child: Center(
                child: Container(
                  height: 60, // Standard FAB size
  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        spreadRadius: 1,
                        offset: Offset(0, 3),
                      ),
                    ],
                    gradient: LinearGradient(
                      colors: [
                        AppColors.lime,
                        AppColors.lime.withOpacity(0.9),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: _showAddTaskBottomSheet,
                    child: Icon(Icons.add, color: Colors.white, size: 24),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutItem(String emoji, String value, String label) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.greycolor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(18.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  height: 5.h,
                  width: 10.w,
                  decoration: BoxDecoration(
                    color: AppColors.appWhite.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      )],
                  ),
                  child: Center(
                    child: CustomText(text: emoji, fontSize: 16.sp),
                  ),
                ),
              ],
            ),
            8.0.width,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(
                  textAlign: TextAlign.start,
                  text: value,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  textAlign: TextAlign.start,
                  text: label,
                  fontSize: 10.sp,
                  color: CupertinoColors.systemGrey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}