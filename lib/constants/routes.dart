// lib/routes/app_pages.dart
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:goto/Constants/constant.dart';
import 'package:goto/views/home/home-view.dart' show HomeView;
import 'package:goto/views/screens/plans/personal-plans.dart';
import 'package:goto/views/screens/plans/plans-screen.dart';
import 'package:goto/views/screens/weekly-plans.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
    ),
    GetPage(
      name: Routes.PERSONAL_PLANS,
      page: () => PersonalPlansScreen(),
    ),
    GetPage(
      name: Routes.WORK_PLANS,
      page: () => WeeklyPlansScreen(),
    ),
    GetPage(
      name: Routes.ALL_PLANS,
      page: () => PlansScreen(),
    ),
    // Add other routes here
  ];
}