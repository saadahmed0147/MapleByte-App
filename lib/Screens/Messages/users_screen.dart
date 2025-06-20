import 'package:flutter/material.dart';
import 'package:maple_byte/Component/curved_appbar.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [CurvedAppBar()]));
  }
}
