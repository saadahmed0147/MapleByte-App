import 'package:flutter/material.dart';
import 'package:maple_byte/Component/curved_appbar.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [CurvedAppBar()]));
  }
}
