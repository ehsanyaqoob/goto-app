import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goto/constants/exports.dart';
import 'package:sizer/sizer.dart';

class OngoinPlansScreen extends StatefulWidget {
  const OngoinPlansScreen({super.key});

  @override
  State<OngoinPlansScreen> createState() => _OngoinPlansScreenState();
}

class _OngoinPlansScreenState extends State<OngoinPlansScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  final List<Map<String, String>> plans = [
    {'emoji': '📚', 'title': 'Study iOS Design Patterns', 'c1': 'Review MVC vs MVVM', 'c2': 'Build demo app using MVVM'},
    {'emoji': '💼', 'title': 'Client Work - SwiftUI Tasks', 'c1': 'Fix navigation bugs', 'c2': 'Add animations to dashboard'},
    {'emoji': '🧠', 'title': 'Daily Brain Training', 'c1': 'Solve 2 puzzles', 'c2': 'Watch 1 learning video'},
    {'emoji': '🏃‍♂️', 'title': 'Fitness Routine', 'c1': '30 mins cardio', 'c2': 'Stretch & cool down'},
    {'emoji': '📝', 'title': 'Write Blog Post', 'c1': 'Draft intro & outline', 'c2': 'Publish on Medium'},
    {'emoji': '🎧', 'title': 'Listen to Podcasts', 'c1': 'Swift over Coffee', 'c2': 'iOS Dev Discussions'},
    {'emoji': '👨‍💻', 'title': 'Portfolio Update', 'c1': 'Add latest projects', 'c2': 'Update resume'},
    {'emoji': '🌍', 'title': 'Learn Spanish', 'c1': '10 Duolingo lessons', 'c2': 'Watch 1 Spanish show'},
    {'emoji': '🎨', 'title': 'Work on UI Kit', 'c1': 'Design dashboard screen', 'c2': 'Add dark mode support'},
    {'emoji': '📈', 'title': 'Track Habits', 'c1': 'Review weekly report', 'c2': 'Plan next 7 days'},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _animations = List.generate(
      plans.length,
      (index) => CurvedAnimation(
        parent: _controller,
        curve: Interval(index * 0.08, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedCard(int index) {
    final plan = plans[index];
    return AnimatedBuilder(
      animation: _animations[index],
      builder: (context, child) {
        return Opacity(
          opacity: _animations[index].value,
          child: Transform.translate(
            offset: Offset(0, 40 * (1 - _animations[index].value)),
            child: child,
          ),
        );
      },
      child: Hero(
        tag: 'ongoing-card-$index',
        child: OngoingPlanCard(
          emojiIcon: plan['emoji']!,
          title: plan['title']!,
          checkbox1Text: plan['c1']!,
          checkbox2Text: plan['c2']!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'On Going Plans',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.greycolor,
          ),
        ),
        backgroundColor: Colors.white.withOpacity(0.9),
        border: null,
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: CupertinoScrollbar(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: plans.length,
              itemBuilder: (context, index) => _buildAnimatedCard(index),
            ),
          ),
        ),
      ),
    );
  }
}

class OngoingPlanCard extends StatefulWidget {
  final String emojiIcon;
  final String title;
  final String checkbox1Text;
  final String checkbox2Text;

  const OngoingPlanCard({
    super.key,
    required this.emojiIcon,
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
    return Material( // Fixes Checkbox error (needs Material parent)
      color: Colors.transparent,
      child: ClipRRect(
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
                color: AppColors.primary.withOpacity(0.2),
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
                Row(
                  children: [
                    Container(
                      height: 5.5.h,
                      width: 5.5.h,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          widget.emojiIcon,
                          style: TextStyle(fontSize: 18.sp),
                        ),
                      ),
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
                      activeColor: AppColors.lime,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
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
                      activeColor: AppColors.lime,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
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
      ),
    );
  }
}
