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

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //# home app bar
            HomeAppBar(
              backgroundColor: AppColors.scaffoldBackgroundColor,
              userName: 'Tahir Abbas!',
              onNotificationPressed: () {},
            ),
            SizedBox(height: 2.h),
            //# task progress card
            TaskProgressCard(
              title: "Excellent, Today's",
              subtitle: "plan is almost done",
              progress: 0.8,
              actionText: "View Plan",
              onActionPressed: () {},
            ),
            10.height,
            //# category and view all
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
                  onTap: () {
                    Get.to(
                      () => PlansScreen(),
                      transition: Transition.rightToLeft,
                      duration: Duration(milliseconds: 300),
                    ); // replace with actual page
                  },
                  child: CustomText(
                    text: 'View All',
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.greycolor,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PlanCard(
                    icon: Icons.person_outline,
                    title: 'Personal Plans',
                    subtitle: '3 plans remaining',
                    onTap: () {
                      Get.to(
                        () => PersonalPlansScreen(),
                        transition: Transition.rightToLeft,
                        duration: Duration(milliseconds: 300),
                      ); // replace with actual page
                    },
                  ),
                  PlanCard(
                    icon: Icons.work_outline,
                    title: 'Work Plans',
                    subtitle: '3 plans remaining',
                    onTap: () {
                      print('Work Plans');
            
                      Get.to(
                        () => WorkPlansScreen(),
                        transition: Transition.rightToLeft,
                        duration: Duration(milliseconds: 300),
                      ); // replace with actual page
                    },
                  ),
                ],
              ),
            ),
            //# on going plans
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
                  onTap: () {
                    Get.to(
                      () => OngoinPlansScreen(),
                      transition: Transition.rightToLeft,
                      duration: Duration(milliseconds: 300),
                    ); // replace with actual page
                  },
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
          OngoingPlanCard(
                icon: Icons.school_outlined,
                title: "Study iOS Design Patterns",
                checkbox1Text: "Review MVC vs MVVM",
                checkbox2Text: "Build demo app using MVVM",
              ),

              // Second card
              OngoingPlanCard(
                icon: Icons.work_outline,
                title: "Client Work - SwiftUI Tasks",
                checkbox1Text: "Fix navigation bugs",
                checkbox2Text: "Add animations to dashboard",
      
        
            ),


          ],
        ),
      ),
    );
  }
}
