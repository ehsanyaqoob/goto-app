import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;

  void setIndex(int index) {
    currentIndex.value = index;
  }
}

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  final List<Map<String, dynamic>> plans = [
    {
      'title': 'Basic',
      'description': 'Access to basic features',
      'price': '\$4.99/mo',
      'color': CupertinoColors.systemBlue
    },
    {
      'title': 'Pro',
      'description': 'Unlock advanced tools',
      'price': '\$9.99/mo',
      'color': CupertinoColors.systemGreen
    },
    {
      'title': 'Enterprise',
      'description': 'All features + support',
      'price': '\$19.99/mo',
      'color': CupertinoColors.systemOrange
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Plans'),
        border: null,
      ),
      child: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: plans.length,
          itemBuilder: (context, index) {
            final plan = plans[index];
            final isSelected = controller.currentIndex.value == index;

            return GestureDetector(
              onTap: () => controller.setIndex(index),
              child: Hero(
                tag: 'plan_$index',
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isSelected ? plan['color'] : CupertinoColors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: CupertinoColors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plan['title'],
                        style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        plan['description'],
                        style: TextStyle(
                          fontSize: 16,
                          color: isSelected ? Colors.white70 : CupertinoColors.systemGrey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        plan['price'],
                        style: TextStyle(
                          fontSize: 16,
                          color: isSelected ? Colors.white : CupertinoColors.systemGrey,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
