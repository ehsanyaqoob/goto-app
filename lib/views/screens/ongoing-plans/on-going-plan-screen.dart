import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goto/constants/exports.dart';
import 'package:sizer/sizer.dart';

class OngoinPlansScreen extends StatefulWidget {
  const OngoinPlansScreen({Key? key}) : super(key: key);

  @override
  State<OngoinPlansScreen> createState() => _OngoinPlansScreenState();
}

class _OngoinPlansScreenState extends State<OngoinPlansScreen> 
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _cardAnimations;

 final List<Map<String, String>> plans = [
  {
    'emoji': '📚',
    'title': 'Study iOS Design Patterns\nand responsive on mobile',
    'c1': 'Review MVC vs MVVM',
    'c2': 'Build demo app using MVVM',
  },
  {
    'emoji': '💼',
    'title': 'Client Work - SwiftUI Tasks',
    'c1': 'Fix navigation bugs',
    'c2': 'Add animations to dashboard',
  },
  {
    'emoji': '🧠',
    'title': 'Daily Brain Training',
    'c1': 'Solve 2 puzzles',
    'c2': 'Watch 1 learning video',
  },
  {
    'emoji': '🏃‍♂️',
    'title': 'Fitness Routine',
    'c1': '30 mins cardio',
    'c2': 'Stretch & cool down',
  },
  {
    'emoji': '📝',
    'title': 'Write Blog Post',
    'c1': 'Draft intro & outline',
    'c2': 'Publish on Medium',
  },
  {
    'emoji': '🎧',
    'title': 'Listen to Podcasts',
    'c1': 'Swift over Coffee',
    'c2': 'iOS Dev Discussions',
  },
  {
    'emoji': '👨‍💻',
    'title': 'Portfolio Update',
    'c1': 'Add latest projects',
    'c2': 'Update resume',
  },
  {
    'emoji': '🌍',
    'title': 'Learn Spanish',
    'c1': '10 Duolingo lessons',
    'c2': 'Watch 1 Spanish show',
  },
  {
    'emoji': '🎨',
    'title': 'Work on UI Kit',
    'c1': 'Design dashboard screen',
    'c2': 'Add dark mode support',
  },
  {
    'emoji': '📈',
    'title': 'Track Habits',
    'c1': 'Review weekly report',
    'c2': 'Plan next 7 days',
  },
];
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Create staggered animations for each card
    _cardAnimations = List.generate(
      plans.length,
      (index) => Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            0.1 * index, 
            0.3 + (0.7 * index / plans.length),
            curve: Curves.easeOutQuad,
          ),
        ),
    ));

    // Start animation after frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(
            CupertinoIcons.back,
            color: AppColors.primary,
            size: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        middle: Text(
          'On Going Plans',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.greycolor,
          ),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(
            CupertinoIcons.forward,
            color: AppColors.primary,
            size: 24,
          ),
          onPressed: () {
            // Add forward navigation logic
          },
        ),
        backgroundColor: Colors.white.withOpacity(0.9),
        border: null,
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return _buildPlanCard(index);
                  },
                  childCount: plans.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard(int index) {
    final plan = plans[index];
    return AnimatedBuilder(
      animation: _cardAnimations[index],
      builder: (context, child) {
        return Opacity(
          opacity: _cardAnimations[index].value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - _cardAnimations[index].value)),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 2.h),
        child: _OngoingPlanCard(
          emojiIcon: plan['emoji']!,
          title: plan['title']!,
          checkbox1Text: plan['c1']!,
          checkbox2Text: plan['c2']!,
        ),
      ),
    );
  }
}

class _OngoingPlanCard extends StatefulWidget {
  final String emojiIcon;
  final String title;
  final String checkbox1Text;
  final String checkbox2Text;

  const _OngoingPlanCard({
    required this.emojiIcon,
    required this.title,
    required this.checkbox1Text,
    required this.checkbox2Text,
  });

  @override
  State<_OngoingPlanCard> createState() => __OngoingPlanCardState();
}

class __OngoingPlanCardState extends State<_OngoingPlanCard> {
  bool _isChecked1 = false;
  bool _isChecked2 = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          // Handle card tap
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(2.5.h),
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
                    offset: const Offset(0, 4),
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
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  _buildCheckboxRow(
                    value: _isChecked1,
                    text: widget.checkbox1Text,
                    onChanged: (value) => setState(() => _isChecked1 = value!),
                  ),
                  _buildCheckboxRow(
                    value: _isChecked2,
                    text: widget.checkbox2Text,
                    onChanged: (value) => setState(() => _isChecked2 = value!),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckboxRow({
    required bool value,
    required String text,
    required ValueChanged<bool?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.2,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.lime,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 10.sp,
                decoration: value ? TextDecoration.lineThrough : null,
                color: value ? Colors.grey : null,
              ),
            ),
          ),
        ],
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
    return Material(
      // Fixes Checkbox error (needs Material parent)
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
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),

                // Checkbox 1
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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

                // Checkbox 2
              ],
            ),
          ),
        ),
      ),
    );
  }
}
