import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goto/constants/exports.dart';
import 'package:goto/views/home/home-view.dart';
import 'package:goto/views/home/profile-view.dart';
import 'package:goto/views/home/task-view.dart';

class NavigationController extends GetxController {
  var currentIndex = 0.obs;
  void changeTab(int index) => currentIndex.value = index;
}

class IosStyleBottomBar extends StatelessWidget {
  IosStyleBottomBar({super.key});
  final navCtrl = Get.put(NavigationController());

  final List<Widget> _pages = const [
    HomeView(key: ValueKey(0)),
    TaskView(key: ValueKey(1)),
    ProfileView(key: ValueKey(2)),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Obx(
        () => Stack(
          children: [
            Positioned.fill(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  final offset = Tween<Offset>(
                    begin: const Offset(0.1, 0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut,
                  ));
                  final fade = CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut,
                  );
                  return SlideTransition(
                    position: offset,
                    child: FadeTransition(opacity: fade, child: child),
                  );
                },
                child: _pages[navCtrl.currentIndex.value],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.only(bottom: 12, top: 6),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemBackground,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(3, (index) => _buildIcon(index)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(int index) {
    final icons = [
      CupertinoIcons.home,
      CupertinoIcons.check_mark_circled,
      CupertinoIcons.person,
    ];
    final labels = ["Home", "Tasks", "Profile"];
    return GestureDetector(
      onTap: () => navCtrl.changeTab(index),
      child: Obx(
        () {
          final isActive = navCtrl.currentIndex.value == index;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: isActive
                  ? CupertinoColors.activeBlue.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icons[index],
                  color: isActive
                      ? CupertinoColors.activeBlue
                      : CupertinoColors.inactiveGray,
                ),
                const SizedBox(height: 2),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: TextStyle(
                    color: isActive
                        ? CupertinoColors.activeBlue
                        : CupertinoColors.inactiveGray,
                    fontSize: 10,
                  ),
                  child: Text(labels[index]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}