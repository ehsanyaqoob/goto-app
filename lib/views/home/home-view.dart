import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goto/constants/exports.dart';
import 'package:goto/views/screens/ongoing-plans/on-going-plan-screen.dart';
import 'package:goto/views/screens/plans/personal-plans.dart';
import 'package:goto/views/screens/plans/plans-screen.dart';
import 'package:goto/views/screens/plans/work-plans.dart';
import 'package:goto/widgets/custom_text.dart';
import 'package:goto/widgets/home-widgets/plan-card.dart';
import 'package:goto/widgets/home-widgets/task-bar.dart';
import 'package:goto/widgets/home_bar_widget.dart';
import 'package:goto/widgets/sizer.dart';
import 'package:sizer/sizer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void navigateCupertino(Widget page) {
    Navigator.push(context, CupertinoPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CupertinoHomeAppBar(
                    backgroundColor: AppColors.scaffoldBackgroundColor,
                    userName: 'Zarie Carder!',
                    onNotificationPressed: () {
                      // Navigate to notifications
                    },
                  ),

                  SizedBox(height: 2.h),

                  CupertinoTaskProgressCard(
                    title: "Excellent, Today's Your",
                    subtitle: "plan is almost done",
                    progress: 0.78,
                    actionText: "View Plan",
                    onActionPressed: () {
                      print("Go to plan");
                    },
                  ),

                  16.0.height,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Category',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                      GestureDetector(
                        onTap: () => navigateCupertino(PlansScreen()),
                        child: CustomText(
                          text: 'See All',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.greycolor,
                        ),
                      ),
                    ],
                  ),
                  10.height,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Hero(
                        tag: 'personal-plan-card',
                        child: PlanCard(
                          icon: Icons.person_2_rounded,
                          title: 'Personal Plans',
                          subtitle: '3 plans remaining',
                          onTap: () => navigateCupertino(PersonalPlansScreen()),
                        ),
                      ),
                      Hero(
                        tag: 'work-plan-card',
                        child: PlanCard(
                          icon: Icons.work_history,
                          title: 'Work Plans',
                          subtitle: '3 plans remaining',
                          onTap: () => navigateCupertino(WorkPlansScreen()),
                        ),
                      ),
                    ],
                  ),
                  20.height,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'On Going Plans',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                      GestureDetector(
                        onTap: () => navigateCupertino(OngoinPlansScreen()),
                        child: CustomText(
                          text: 'View All',
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.greycolor,
                        ),
                      ),
                    ],
                  ),

                  10.height,
                  Hero(
                    tag: 'ongoing-card-1',
                    child: OngoingPlanCard(
                      emojiIcon: '📚',
                      title: "Study iOS Design Patterns",
                      checkbox1Text: "Review MVC vs MVVM",
                      checkbox2Text: "Build demo app using MVVM",
                    ),
                  ),

                  Hero(
                    tag: 'ongoing-card-2',
                    child: OngoingPlanCard(
                      emojiIcon: '💼',
                      title: "Client Work - SwiftUI Tasks",
                      checkbox1Text: "Fix navigation bugs",
                      checkbox2Text: "Add animations to dashboard",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
