import 'package:flutter/material.dart';
import 'package:maple_byte/Component/curved_appbar.dart';

class FinishedScreen extends StatefulWidget {
  const FinishedScreen({super.key});

  @override
  State<FinishedScreen> createState() => _FinishedScreenState();
}

class _FinishedScreenState extends State<FinishedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [CurvedAppBar()]));
  }
}
