import 'package:flutter/material.dart';
import 'package:maple_byte/Component/Appbar/curved_appbar.dart';
import 'package:maple_byte/Utils/app_colors.dart';

class FinishedScreen extends StatefulWidget {
  const FinishedScreen({super.key});

  @override
  State<FinishedScreen> createState() => _FinishedScreenState();
}

class _FinishedScreenState extends State<FinishedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(children: [CurvedAppBar()]),
    );
  }
}
