import 'package:flutter/material.dart';
import 'package:maple_byte/Component/Appbar/curved_appbar.dart';
import 'package:maple_byte/Screens/Home/finished_screen.dart';
import 'package:maple_byte/Screens/Home/progress_screen.dart';
import 'package:maple_byte/Screens/Home/todo_screen.dart';
import 'package:maple_byte/Utils/app_colors.dart';

class TopNavigator extends StatefulWidget {
  const TopNavigator({super.key});

  @override
  State<TopNavigator> createState() => _TopNavigatorState();
}

class _TopNavigatorState extends State<TopNavigator> {
  int _selectedIndex = 1; // Default to 'In progress'

  final List<String> tabs = ["To do", "In progress", "Finished"];
  final List<Widget> screens = [
    TodoScreen(),
    ProgressScreen(),
    FinishedScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CurvedAppBar(title: "Projects", height: 110, exitIcon: true),
      body: Column(
        children: [
          // Top pill-style tabs with divider
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: const Color(0xffF1F5FF),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(tabs.length * 2 - 1, (i) {
                if (i.isOdd) {
                  // Add vertical divider between buttons
                  return Container(
                    height: 20,
                    width: 1,
                    color: Colors.grey.shade400,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                  );
                }

                final index = i ~/ 2;
                final isSelected = _selectedIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white
                          : const Color(0xffF1F5FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      tabs[index],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.black : Colors.grey.shade600,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          // Tab Body
          Expanded(
            child: IndexedStack(index: _selectedIndex, children: screens),
          ),
        ],
      ),
    );
  }
}
