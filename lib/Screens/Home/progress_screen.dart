import 'package:flutter/material.dart';
import 'package:maple_byte/Component/curved_appbar.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [CurvedAppBar(title: "Projects", height: 110)]);
  }
}
