import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goto/constants/Theme/app_colors.dart';
import 'package:goto/controllers/task_controller.dart';
import 'package:goto/views/screens/plans/plans-screen.dart';
import 'package:goto/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
class CupertinoTaskProgressCard extends StatefulWidget {
  final TaskController taskController;
  final String actionText;
  final VoidCallback? onActionPressed;

  const CupertinoTaskProgressCard({
    super.key,
    required this.taskController,
    required this.actionText,
    this.onActionPressed,
  });

  @override
  State<CupertinoTaskProgressCard> createState() =>
      _CupertinoTaskProgressCardState();
}

class _CupertinoTaskProgressCardState
    extends State<CupertinoTaskProgressCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animatedProgress;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _updateAnimation();
  }

  void _updateAnimation() {
    final completed = widget.taskController.tasks.where((t) => t.isDone).length;
    final total = widget.taskController.tasks.length;
    final double progress = total > 0 ? completed / total : 0;

    _animatedProgress = Tween<double>(
      begin: 0.0,
      end: progress,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward(from: 0);
  }

  @override
  void didUpdateWidget(covariant CupertinoTaskProgressCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.taskController != widget.taskController) {
      _updateAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _getTitle(int completed, int total) {
    if (total == 0) return "No tasks today";
    if (completed == total) return "Excellent! All done";
    if (completed / total >= 0.75) return "Great progress!";
    if (completed / total >= 0.5) return "Good work";
    if (completed > 0) return "Keep going";
    return "Let's get started";
  }

  String _getSubtitle(int completed, int total) {
    if (total == 0) return "Add some tasks";
    if (completed == total) return "You completed all tasks";
    return "${total - completed} more to go";
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final completed = widget.taskController.tasks.where((t) => t.isDone).length;
      final total = widget.taskController.tasks.length;
      final progress = total > 0 ? completed / total : 0;

      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Title and subtitle
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: _getTitle(completed, total),
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 0.5.h),
                        CustomText(
                          text: _getSubtitle(completed, total),
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),

                    // Animated progress
                    AnimatedBuilder(
                      animation: _animatedProgress,
                      builder: (context, _) {
                        return Container(
                          width: 20.w,
                          height: 20.w,
                          alignment: Alignment.center,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: CustomPaint(
                                  painter: _CircleProgressPainter(
                                    progress: _animatedProgress.value,
                                    color: Colors.white,
                                    strokeWidth: 12.0,
                                  ),
                                ),
                              ),
                              CustomText(
                                text: "${(progress * 100).round()}%",
                                fontSize: 11.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),

                CupertinoButton(
                  minSize: 3.0.h,
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.5.h),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  onPressed: () {
                    Get.to(
                      () => PlansScreen(),
                      transition: Transition.cupertino,
                      duration: const Duration(milliseconds: 400),
                    );
                    widget.onActionPressed?.call();
                  },
                  child: CustomText(
                    text: widget.actionText,
                    fontSize: 11.sp,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
class _CircleProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  _CircleProgressPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final basePaint = Paint()
      ..color = color.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, basePaint);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.5708, // -90 degrees
      2 * 3.1416 * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}