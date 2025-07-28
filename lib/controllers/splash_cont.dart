import 'package:flutter_animate/flutter_animate.dart';
import 'package:goto/constants/exports.dart';
import 'package:goto/views/intial-view.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  final RxDouble _animationValue = 0.0.obs;
  final RxInt _currentDot = 0.obs;
  final int _totalDots = 4;
  final int _cycles = 10;

  // Public getters
  double get animationValue => _animationValue.value;
  int get currentDot => _currentDot.value; // Expose currentDot publicly

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();

    animationController.addListener(() {
      _animationValue.value = animationController.value;
      double progress = _animationValue.value * _cycles;
      _currentDot.value = (progress % _totalDots).floor();
    });

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToHome();
      }
    });
  }

  void _navigateToHome() {
    Get.off(() => InitialView(), transition: Transition.fade, duration: 300.ms);
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
