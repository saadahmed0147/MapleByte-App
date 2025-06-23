import 'package:flutter/material.dart';
import 'package:maple_byte/Component/bottom_wave_clipper.dart';
import 'package:maple_byte/Utils/app_colors.dart';

class CurvedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double height;

  const CurvedAppBar({
    super.key,
    this.title,
    this.height = 60, // default height
  });

  @override
  Size get preferredSize => Size.fromHeight(height); // ✅ Required for appBar

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          ClipPath(
            clipper: BottomWaveClipper(),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [AppColors.lightBlueColor, AppColors.darkBlueColor],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title ?? ' ',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
