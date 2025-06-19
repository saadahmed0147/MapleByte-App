import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:maple_byte/Component/bottom_wave_clipper.dart';

class CurvedAppBar extends StatelessWidget {
  final double height;
  final Color backgroundColor;

  const CurvedAppBar({
    super.key,
    this.height = 180,
    this.backgroundColor = const Color(0xFF3E5BFF), // default blue
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        children: [
          ClipPath(
            clipper: BottomWaveClipper(),
            child: Container(color: backgroundColor),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Services',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Add icons if needed
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
