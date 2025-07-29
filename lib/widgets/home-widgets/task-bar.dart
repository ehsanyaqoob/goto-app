import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goto/constants/Theme/app_colors.dart';
import 'package:goto/views/screens/plans/plans-screen.dart';
import 'package:goto/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
class CupertinoTaskProgressCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final double progress;
  final String actionText;
  final VoidCallback? onActionPressed;

  const CupertinoTaskProgressCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.progress,
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

    _animatedProgress = Tween<double>(
      begin: 0.0,
      end: widget.progress,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        text: widget.title,
                        fontSize: 12.sp,
                        color: CupertinoColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 0.5.h),
                      CustomText(
                        text: widget.subtitle,
                        fontSize: 12.sp,
                        color: CupertinoColors.white,
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
                                  color: AppColors.whiteColor,
                                  strokeWidth: 12.0,
                                ),
                              ),
                            ),
                            CustomText(
                              text:
                                  "${(_animatedProgress.value * 100).round()}%",
                              fontSize: 11.sp,
                              color: CupertinoColors.white,
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
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(16.0),
                onPressed: () {
                  Get.to(
                    () => PlansScreen(),
                    transition: Transition.cupertino,
                    duration: const Duration(milliseconds: 400),
                    arguments: {
                      'title': widget.title,
                      'subtitle': widget.subtitle,
                      'progress': widget.progress,
                    },
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