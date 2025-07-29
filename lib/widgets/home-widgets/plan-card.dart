import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:goto/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:goto/constants/exports.dart';

class PlanCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const PlanCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 16.5.h,
          width: 43.0.w,
          padding: EdgeInsets.all(2.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.6),
                Colors.white.withOpacity(0.3),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.accent.withOpacity(0.2),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon and Title
              Row(
                children: [
                  Container(
                    height: 4.4.h,
                    width: 4.4.h,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    child: Icon(icon, color: AppColors.whiteColor, size: 16.sp),
                  ),
                  SizedBox(width: 2.w),
                  CustomText(
                    text: title,
                    fontSize: 9.0.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,

                    // letterSpacing: 0,
                  ),
                ],
              ),
              SizedBox(height: 1.5.h),

              // Subtitle
              CustomText(
                text: subtitle,
                fontSize: 9.sp,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w400,
              ),

              const Spacer(),

              // "Go to Plan" CTA
              GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact(); // iOS-style feedback
                  onTap();
                },
                child: Row(
                  children: [
                    CustomText(
                      text: "Go to Plan",
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 2.w),
                    Icon(
                      Icons.arrow_forward,
                      size: 16.0.sp,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
