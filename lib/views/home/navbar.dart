import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goto/constants/Theme/app_colors.dart';
import 'package:goto/controllers/add-task-model.dart';
import 'package:goto/controllers/task_controller.dart';
import 'package:goto/views/home/home-view.dart';
import 'package:goto/views/home/profile-view.dart';
import 'package:goto/views/screens/analytics-view.dart';
import 'package:goto/views/screens/task-view.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  final TaskController taskController = Get.put(TaskController());
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeView(),
    TaskView(),       // Calendar view showing tasks
    const SizedBox.shrink(), // Placeholder for FAB
    AnalyticsView(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      _showAddTaskBottomSheet();
      return;
    }
    setState(() => _currentIndex = index);
  }

  void _showAddTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>  AddTaskBottomSheet(),
    );
  }

  Widget _buildIcon(int index, IconData filled, IconData outline) {
    final isActive = _currentIndex == index;
    return Icon(
      isActive ? filled : outline,
      color: isActive ? Colors.white : AppColors.greylight,
      size: 26,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          color: AppColors.primary,
          elevation: 12,
          child: SizedBox(
            height: 72,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: _buildIcon(0, CupertinoIcons.house_fill, CupertinoIcons.house),
                  onPressed: () => _onItemTapped(0),
                ),
                IconButton(
                  icon: _buildIcon(1, CupertinoIcons.calendar, CupertinoIcons.calendar_today),
                  onPressed: () => _onItemTapped(1),
                ),
                const SizedBox(width: 48), // For FAB
                IconButton(
                  icon: _buildIcon(3, CupertinoIcons.graph_circle_fill, CupertinoIcons.graph_circle),
                  onPressed: () => _onItemTapped(3),
                ),
                IconButton(
                  icon: _buildIcon(4, CupertinoIcons.person_solid, CupertinoIcons.person),
                  onPressed: () => _onItemTapped(4),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
  height: 56, // Standard FAB size
  width: 56,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.3),
        blurRadius: 8,
        spreadRadius: 1,
        offset: Offset(0, 3),
      ),
    ],
    gradient: LinearGradient(
      colors: [
        AppColors.lime,
        AppColors.lime.withOpacity(0.9),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  child: FloatingActionButton(
    onPressed: _showAddTaskBottomSheet,
    backgroundColor: Colors.transparent,
    elevation: 0, // Remove default elevation
    child: Icon(Icons.add, color: Colors.white, size: 24),
  ),
),
floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    ));
  }
}
