import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goto/constants/exports.dart'; // Assuming this includes AppColors, etc.
import 'package:sizer/sizer.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final String userName;
  final VoidCallback onNotificationPressed;

  const HomeAppBar({
    super.key,
    required this.backgroundColor,
    required this.userName,
    required this.onNotificationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          color: backgroundColor.withOpacity(0.8),
          // padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 1.h, left: 4.w, right: 4.w, bottom: 1.5.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Profile and greeting
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Good day,",
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),

              // Notification button
              GestureDetector(
                onTap: onNotificationPressed,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.greycolor.withOpacity(0.4),
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
                    color: AppColors.primary,
                    size: 20.sp,
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
