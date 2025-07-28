// controllers/home_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goto/controllers/todo-cont.dart';
import 'package:goto/models/todo-model.dart';
import 'package:goto/views/screens/plans/plans-screen.dart';
import 'package:goto/views/screens/todo-view.dart';

class HomeController extends GetxController 
    with GetSingleTickerProviderStateMixin {
  final TodoController todoController = Get.find();
  
  late AnimationController animationController;
  final RxDouble _scrollOffset = 0.0.obs;
  final RxBool _showFab = true.obs;

  double get scrollOffset => _scrollOffset.value;
  bool get showFab => _showFab.value;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void updateScrollOffset(double offset) {
    _scrollOffset.value = offset;
    _showFab.value = offset < 100; // Hide FAB when scrolling down
  }

  // Future<void> refreshData() async {
  //   animationController.repeat(reverse: true);
  //   await todoController.fetchTodos();
  //   animationController.stop();
  // }

  void navigateToPlans() {
    Get.to(
      () => PlansScreen(),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutQuart,
    );
  }

  void navigateToCreateTodo() {
    Get.to(
      () => CreateTodoView(),
      transition: Transition.downToUp,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutBack,
    );
  }
}