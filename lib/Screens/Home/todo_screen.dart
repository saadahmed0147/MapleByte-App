import 'package:flutter/material.dart';
import 'package:maple_byte/Component/curved_appbar.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [CurvedAppBar()]));
  }
}
