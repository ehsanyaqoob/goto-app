// lib/controllers/navigation_controller.dart
import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// initial Controller 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goto/constants/Theme/app_assets.dart';

class NavigationController with ChangeNotifier {
  final NotchBottomBarController _bottomBarController = NotchBottomBarController(index: 0);
  int _currentIndex = 0;

  NotchBottomBarController get bottomBarController => _bottomBarController;
  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    _currentIndex = index;
    _bottomBarController.index = index;
    notifyListeners();
  }

  void dispose() {
    _bottomBarController.dispose();
    super.dispose();
  }
}


// class InitialController extends GetxController with GetSingleTickerProviderStateMixin {
//   late AnimationController animationController;
//   late Animation<Offset> imageSlide;
//   late Animation<double> imageFade;
//   late Animation<Offset> bottomSlide;

//   final isImagePrecached = false.obs;

//   @override
//   void onInit() {
//     super.onInit();

//     animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     );

//     final curve = CurvedAnimation(
//       parent: animationController,
//       curve: Curves.fastOutSlowIn,
//     );

//     imageSlide = Tween<Offset>(
//       begin: const Offset(0, -1.5),
//       end: Offset.zero,
//     ).animate(curve);

//     imageFade = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(curve);

//     bottomSlide = Tween<Offset>(
//       begin: const Offset(0, 1.2),
//       end: Offset.zero,
//     ).animate(curve);
//   }

//   void startAnimation(BuildContext context) {
//     if (!isImagePrecached.value) {
//       precacheImage(const AssetImage(AppAssets.boardingScreen1), context).then((_) {
//         isImagePrecached.value = true;
//         animationController.forward();
//       });
//     }
//   }

//   @override
//   void onClose() {
//     animationController.dispose();
//     super.onClose();
//   }
// }
