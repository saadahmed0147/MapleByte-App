import 'package:flutter/material.dart';

class QuoteCardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Start from top-left
    path.moveTo(0, 0);

    // Top inward curve
    path.quadraticBezierTo(size.width / 2, 60, size.width, 0);

    // Right edge down
    path.lineTo(size.width, size.height);

    // Bottom inward curve
    path.quadraticBezierTo(size.width / 2, size.height - 60, 0, size.height);

    // Close path
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
