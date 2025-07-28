import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goto/Constants/Theme/app_colors.dart';
import 'package:goto/views/screens/plans/plans-screen.dart';
import 'package:goto/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class TaskProgressCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress;
  final String actionText;
  final VoidCallback? onActionPressed;

  const TaskProgressCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.actionText,
    this.onActionPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF0A0A1F).withOpacity(0.95),
            const Color(0xFF1A1A35).withOpacity(0.95),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 24,
            spreadRadius: 2,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: title,
                    fontSize: 12.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 0.5.h),
                  CustomText(
                    text: subtitle,
                    fontSize: 12.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              // iOS-style circular progress indicator
              SizedBox(
                width: 20.w,
                height: 20.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background circle
                    Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    // Progress arc
                    SizedBox(
                      width: 30.w,
                      height: 30.w,
                      child: CustomPaint(
                        painter: _CircleProgressPainter(
                          progress: progress,
                          color: Colors.white,
                          strokeWidth: 10.0,
                        ),
                      ),
                    ),
                    // Percentage text
                    CustomText(
                      text: '${(progress * 100).round()}%',
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                Get.to(
                  PlansScreen(),
                  transition: Transition.rightToLeft,
                  duration: const Duration(milliseconds: 400),
                  arguments: {
                    'title': title,
                    'subtitle': subtitle,
                    'progress': progress,
                  },
                );
                onActionPressed?.call();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                child: CustomText(
                  text: actionText,
                  fontSize: 12.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Draw the progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -0.5 * 3.1416, // Start at top (-90 degrees)
      2 * 3.1416 * progress, // Sweep angle
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}