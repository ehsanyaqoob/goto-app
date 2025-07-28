import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goto/constants/Theme/app_assets.dart';
import 'package:sizer/sizer.dart';
import 'package:goto/constants/exports.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header with avatar
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 22.h,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withOpacity(0.2),
                            AppColors.scaffoldBackgroundColor,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Hero(
                        tag: 'profile-avatar',
                        child: CircleAvatar(
                          radius: 45.0.sp,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 38.sp,
                            backgroundImage: AssetImage(AppAssets.ellipse),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Content
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Name and email
                  Column(
                    children: [
                      Text(
                        "Tahir Abbas",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ).animate().fadeIn(duration: 300.ms),
                      SizedBox(height: 0.5.h),
                      Text(
                        "tahir@example.com",
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.grey.shade600,
                        ),
                      ).animate().fadeIn(duration: 400.ms),
                    ],
                  ),

                  SizedBox(height: 3.h),

                  // Bio Section
                  _buildProfileCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ABOUT ME",
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade500,
                            letterSpacing: 1.2,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          "Mobile app developer with a passion for Flutter and elegant UI design. I love crafting user-centric apps with a modern feel.",
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.grey.shade800,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ).animate().slideX(begin: -0.1, end: 0, duration: 500.ms),

                  // Details Section
                  _buildProfileCard(
                    child: Column(
                      children: [
                        _buildDetailTile(
                          icon: CupertinoIcons.phone,
                          title: "Phone",
                          value: "+92 300 1234567",
                        ),
                        Divider(height: 2.h, color: Colors.grey.shade200),
                        _buildDetailTile(
                          icon: CupertinoIcons.location,
                          title: "Location",
                          value: "Islamabad, Pakistan",
                        ),
                        Divider(height: 2.h, color: Colors.grey.shade200),
                        _buildDetailTile(
                          icon: CupertinoIcons.calendar,
                          title: "Joined",
                          value: "Jan 15, 2024",
                        ),
                      ],
                    ),
                  ).animate().slideX(begin: 0.1, end: 0, duration: 500.ms),

                  // Skills Section
                  _buildProfileCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "SKILLS & INTERESTS",
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade500,
                            letterSpacing: 1.2,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Wrap(
                          spacing: 2.w,
                          runSpacing: 1.5.h,
                          children: [
                            _buildSkillChip("Flutter"),
                            _buildSkillChip("Firebase"),
                            _buildSkillChip("UI/UX Design"),
                            _buildSkillChip("Dart"),
                            _buildSkillChip("Swift"),
                            _buildSkillChip("JavaScript"),
                          ],
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 600.ms),

                  SizedBox(height: 2.h),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard({required Widget child}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildDetailTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20.sp),
        SizedBox(width: 4.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 10.sp, color: Colors.grey.shade600),
              ),
              SizedBox(height: 0.5.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSkillChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 10.sp, color: AppColors.primary),
      ),
    );
  }
}
