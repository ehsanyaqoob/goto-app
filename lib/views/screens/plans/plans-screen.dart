import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goto/constants/Theme/app_colors.dart';
import 'package:goto/controllers/task_controller.dart';
import 'package:goto/widgets/animated-entry/week-calendar.dart';
import 'package:goto/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key});

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  final TaskController controller = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBar(
         elevation: 0,
  leading: IconButton(
    icon: const Icon(CupertinoIcons.back, size: 24),
    color: AppColors.primary,
    onPressed: () {
      Navigator.of(context).pop(); 
    },
  ),
      
        title: CustomText(
          text: "📅 Today's Progress",
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, size: 20),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          final completed = controller.tasks.where((t) => t.isDone).length;
          final total = controller.tasks.length;
          final double progress = total > 0 ? completed / total : 0;

          return ListView(
            padding: const EdgeInsets.all(16),
            physics: const BouncingScrollPhysics(),
            children: [
              _glassContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "Today's Achievement",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: 1.h),
                    CustomText(
                      text: completed == total && total != 0
                          ? "🎉 You've completed all $total tasks!"
                          : "You've completed $completed out of $total tasks",
                      fontSize: 11.5.sp,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 2.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: AppColors.greycolor.withOpacity(0.15),
                        color: AppColors.primary,
                        minHeight: 10,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),

              // Compact Week Calendar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
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
                        selectedDate: controller.selectedDate.value,
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
              SizedBox(height: 2.h),

              CustomText(
                text: "📊 Workout Report",
                fontSize: 14.5.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
              SizedBox(height: 1.5.h),

              _workoutRow([
                _buildWorkoutItem("🔥", "${(300 * progress).round()}kCal", "Calories Burned"),
                _buildWorkoutItem("🏃", "${(10 * progress).toStringAsFixed(1)}g", "Fat Burned"),
              ]),
              SizedBox(height: 1.5.h),
              _workoutRow([
                _buildWorkoutItem("💪", "${(25 * progress).round()}g", "Carbs Burned"),
                _buildWorkoutItem("⏱️", "${(30 * progress).toStringAsFixed(1)}g", "Protein Gained"),
              ]),
              SizedBox(height: 3.h),

              _glassContainer(
                child: Column(
                  children: [
                    CustomText(
                      text: "📝 Daily Summary",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: 1.h),
                    CustomText(
                      text: _getSummaryText(completed, total),
                      fontSize: 11.sp,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
            ],
          );
        }),
      ),
    );
  }

  Widget _glassContainer({
    required Widget child,
    EdgeInsetsGeometry? padding,
    double? height,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: height,
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.whiteColor.withOpacity(0.25),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _workoutRow(List<Widget> children) {
    return Row(
      children: children
          .map((child) => Expanded(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: child,
              )))
          .toList(),
    );
  }

  Widget _buildWorkoutItem(String emoji, String value, String label) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.greycolor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 10.w,
            height: 5.h,
            decoration: BoxDecoration(
              color: AppColors.whiteColor.withOpacity(0.85),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(emoji, style: TextStyle(fontSize: 16.sp)),
            ),
          ),
          SizedBox(width: 2.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: value,
                fontSize: 12.5.sp,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                text: label,
                fontSize: 10.sp,
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getSummaryText(int completed, int total) {
    if (total == 0) {
      return "No tasks planned for today. Let's add some and get started!";
    }
    if (completed == 0) {
      return "You haven't completed anything yet. Let's crush it!";
    }
    if (completed == total) {
      return "🎯 Incredible! You completed every single task today!";
    }
    final remaining = total - completed;
    return "You're doing great! Just $remaining more ${remaining == 1 ? 'task' : 'tasks'} to go.";
  }
}