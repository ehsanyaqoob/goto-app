import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goto/constants/exports.dart';
import 'package:goto/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class OngoinPlansScreen extends StatefulWidget {
  const OngoinPlansScreen({super.key});

  @override
  State<OngoinPlansScreen> createState() => _OngoinPlansScreenState();
}

class _OngoinPlansScreenState extends State<OngoinPlansScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: Column(
        children: [
          CustomText(text: 'On Going Plans'),
        ],
      ),
    );
  }
}


class OngoingPlanCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String checkbox1Text;
  final String checkbox2Text;

  const OngoingPlanCard({
    super.key,
    required this.icon,
    required this.title,
    required this.checkbox1Text,
    required this.checkbox2Text,
  });

  @override
  State<OngoingPlanCard> createState() => _OngoingPlanCardState();
}

class _OngoingPlanCardState extends State<OngoingPlanCard> {
  bool isChecked1 = false;
  bool isChecked2 = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(2.5.h),
          margin: EdgeInsets.only(bottom: 2.h),
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
              color: Colors.white.withOpacity(0.2),
              width: 0.6,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
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
                    height: 5.5.h,
                    width: 5.5.h,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(widget.icon, color: AppColors.primary, size: 18.sp),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.greycolor,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),

              // Checkbox 1
              Row(
                children: [
                  Checkbox(
                    value: isChecked1,
                    onChanged: (val) {
                      setState(() {
                        isChecked1 = val!;
                      });
                    },
                    activeColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.checkbox1Text,
                      style: TextStyle(fontSize: 10.sp),
                    ),
                  ),
                ],
              ),

              // Checkbox 2
              Row(
                children: [
                  Checkbox(
                    value: isChecked2,
                    onChanged: (val) {
                      setState(() {
                        isChecked2 = val!;
                      });
                    },
                    activeColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.checkbox2Text,
                      style: TextStyle(fontSize: 10.sp),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


