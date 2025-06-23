import 'package:flutter/material.dart';
import 'package:maple_byte/Component/Appbar/curved_appbar.dart';
import 'package:maple_byte/Utils/app_colors.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(children: [CurvedAppBar()]),
    );
  }
}
