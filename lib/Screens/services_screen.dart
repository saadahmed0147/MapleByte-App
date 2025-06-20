import 'package:flutter/material.dart';
import 'package:maple_byte/Component/curved_appbar.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [CurvedAppBar()]));
  }
}
