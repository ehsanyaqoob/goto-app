import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goto/constants/Theme/app_colors.dart';
import 'package:goto/views/home/home-view.dart';
import 'package:goto/views/home/profile-view.dart';
import 'package:goto/views/home/task-view.dart';
import 'package:goto/views/screens/analytics-view.dart';
import 'package:goto/views/screens/calendar-view.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeView(),
    CalendarView(),
    TaskView(), // This is the floating Add
    AnalyticsView(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildIcon(int index, IconData activeIcon, IconData inactiveIcon) {
    final isActive = _currentIndex == index;
    return Icon(
      isActive ? activeIcon : inactiveIcon,
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
                const SizedBox(width: 48), // space for FAB
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
        floatingActionButton: FloatingActionButton(
          onPressed: () => _onItemTapped(2),
          elevation: 10,
          backgroundColor: AppColors.lime,
          shape: const CircleBorder(),
          child: const Icon(CupertinoIcons.add, size: 32, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
