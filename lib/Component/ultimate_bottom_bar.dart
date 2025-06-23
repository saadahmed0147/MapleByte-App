import 'package:flutter/material.dart';
import 'package:ultimate_bottom_navbar/ultimate_bottom_navbar.dart';

class UltimateBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const UltimateBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return UltimateBottomNavBar(
      backgroundColor: Colors.white,
      icons: const [
        Icons.home,
        Icons.home_repair_service,
        Icons.message,
        Icons.newspaper,
        Icons.lightbulb,
      ],
      titles: const ['Home', 'Services', 'Messages', 'News', 'Quotes'],
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
