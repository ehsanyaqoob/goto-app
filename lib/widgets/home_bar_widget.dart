import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goto/constants/exports.dart';
import 'package:goto/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class CupertinoHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final String userName;
  final VoidCallback onNotificationPressed;

  const CupertinoHomeAppBar({
    super.key,
    required this.backgroundColor,
    required this.userName,
    required this.onNotificationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 1.5.h,
            bottom: 1.5.h,
            left: 0.w,
            right: 0.w,
          ),
          color: backgroundColor.withOpacity(0.75),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 👋 Greeting + Name
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 
                    "Wellcome Back",
                          fontSize: 11.sp,
                          color: CupertinoColors.systemGrey,
                          fontWeight: FontWeight.w400,
                      
                  ),
                  CustomText(
                    text: 
                    userName,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                          color: CupertinoColors.black,
                        
                  ),
                ],
              ),

              // 🔔 Notification Button
              CupertinoButton(
                padding: EdgeInsets.zero,
                minSize: 0,
                onPressed: onNotificationPressed,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey4.withOpacity(0.4),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.08),
                        blurRadius: 20,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: Icon(
                    CupertinoIcons.bell,
                    size: 20.sp,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(10.h);
}
