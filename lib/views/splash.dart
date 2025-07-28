import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:goto/constants/exports.dart';
import 'package:goto/controllers/splash_cont.dart';
import 'package:goto/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SplashController());
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 600;

    return Scaffold(
      backgroundColor: AppColors.appWhite,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Adaptive sizing
          final logoSize = isSmallScreen ? 50.w : 40.w;
          final iconSize = isSmallScreen ? 20.w : 25.w;
          final bottomPadding = isSmallScreen ? 10.h : 15.h;
          final titleSize = isSmallScreen ? 24.sp : 30.sp;
          final subtitleSize = isSmallScreen ? 14.sp : 16.sp;

          return Stack(
            children: [
              // Modern iOS-style blur background
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.appWhite,
                        AppColors.appWhite.withOpacity(0.9),
                        AppColors.primary.withOpacity(0.05),
                      ],
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(color: Colors.transparent),
                  ),
                ),
              ),

              // Floating task elements
              Positioned(
                top: 15.h,
                left: 10.w,
                child: _TaskElement(
                  size: isSmallScreen ? 12.w : 8.w,
                  color: AppColors.primary.withOpacity(0.2),
                  delay: 200.ms,
                ),
              ),
              Positioned(
                top: 25.h,
                right: 15.w,
                child: _TaskElement(
                  size: isSmallScreen ? 15.w : 10.w,
                  color: AppColors.primary.withOpacity(0.15),
                  delay: 400.ms,
                ),
              ),
              Positioned(
                bottom: 30.h,
                left: 20.w,
                child: _TaskElement(
                  size: isSmallScreen ? 10.w : 7.w,
                  color: AppColors.primary.withOpacity(0.1),
                  delay: 600.ms,
                ),
              ),

              // Center Content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo Container
                    Container(
                      width: logoSize,
                      height: logoSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Pulsing circle animation
                          Container(
                                width: logoSize * 0.8,
                                height: logoSize * 0.8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primary.withOpacity(0.2),
                                ),
                              )
                              .animate(
                                onPlay: (controller) => controller.repeat(),
                              )
                              .scale(
                                begin: const Offset(1.0, 1.0),
                                end: const Offset(1.5, 1.5),
                                duration: 1500.ms,
                                curve: Curves.easeOutSine,
                              )
                              .fadeOut(),

                          // Checkmark icon
                          Icon(
                                Icons.check_circle_rounded,
                                size: iconSize,
                                color: AppColors.appWhite,
                              )
                              .animate()
                              .scale(
                                begin: const Offset(0.0, 0.0),
                                end: const Offset(1.0, 1.0),
                                duration: 800.ms,
                                curve: Curves.elasticOut,
                              )
                              .fadeIn(duration: 500.ms),
                        ],
                      ),
                    ).animate().scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1.0, 1.0),
                      duration: 1000.ms,
                      curve: Curves.easeOutBack,
                    ),

                    SizedBox(height: isSmallScreen ? 5.h : 8.h),

                    // Corrected progress indicator with proper type handling
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        return Obx(() {
                          // Remove the 'as double' cast and convert properly
                          double distance = (index - controller.currentDot)
                              .toDouble()
                              .abs();
                          double opacity = distance > 1
                              ? 0.2
                              : 1.0 - (distance * 0.4);

                          return Container(
                                margin: EdgeInsets.symmetric(horizontal: 1.5.w),
                                width: isSmallScreen ? 3.5.w : 2.5.w,
                                height: isSmallScreen ? 3.5.w : 2.5.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primary.withOpacity(opacity),
                                ),
                              )
                              .animate(delay: (index * 50).ms)
                              .scale(
                                begin: const Offset(0.9, 0.9),
                                end: const Offset(1.1, 1.1),
                                duration: 200.ms,
                                curve: Curves.easeInOut,
                              );
                        });
                      }),
                    ),
                  ],
                ),
              ),

              // Bottom Text
              Positioned(
                bottom: bottomPadding,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    CustomText(
                          text: 'GoTo',
                          fontSize: titleSize,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        )
                        .animate()
                        .fadeIn(delay: 300.ms)
                        .slideY(
                          begin: 0.5,
                          end: 0,
                          duration: 800.ms,
                          curve: Curves.easeOutCubic,
                        ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TaskElement extends StatelessWidget {
  final double size;
  final Color color;
  final Duration delay;

  const _TaskElement({
    required this.size,
    required this.color,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
        )
        .animate(delay: delay)
        .fadeIn(duration: 800.ms)
        .scale(
          begin: const Offset(0.0, 0.0),
          end: const Offset(1.0, 1.0),
          curve: Curves.easeOutBack,
        );
  }
}
