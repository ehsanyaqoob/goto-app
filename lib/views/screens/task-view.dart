import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goto/constants/Theme/app_colors.dart';
import 'package:goto/controllers/task_controller.dart';
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

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        middle: CustomText(text: "🗓️ My Tasks", fontSize: 18.sp),
        border: null,
        backgroundColor: AppColors.scaffoldBackgroundColor,
      ),
      child: SafeArea(
        child: Obx(() {
          final selectedDate = controller.selectedDate.value;
          final tasks = controller.tasks;
          return Stack(
            children: [
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 12,
                              left: 16,
                              right: 16,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                DateFormat('MMMM yyyy').format(selectedDate),
                                style: TextStyle(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                height: 25.h,
                                width: double.infinity,
                                child: CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.date,
                                  initialDateTime: selectedDate,
                                  onDateTimeChanged:
                                      controller.updateSelectedDate,
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
                            child: Text(
                              "📝 Tasks on ${DateFormat('MMMM d, yyyy').format(selectedDate)}",
                              style: TextStyle(
                                fontSize: 18.sp,
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
                                  color: CupertinoColors
                                      .secondarySystemGroupedBackground,
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
                                      onPressed: () => controller
                                          .toggleTaskCompletion(index),
                                      child: Icon(
                                        task.isDone
                                            ? CupertinoIcons
                                                  .check_mark_circled_solid
                                            : CupertinoIcons.circle,
                                        color: task.isDone
                                            ? CupertinoColors.activeGreen
                                            : CupertinoColors.inactiveGray,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color:
                                                    CupertinoColors.systemGrey,
                                              ),
                                            ),
                                          const SizedBox(height: 2),
                                          Text(
                                            "🕒 ${DateFormat.jm().format(task.date)}",
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color:
                                                  CupertinoColors.systemGrey2,
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
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
