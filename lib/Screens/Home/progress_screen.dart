import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maple_byte/Component/Appbar/curved_appbar.dart';
import 'package:maple_byte/Route/route_names.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, RouteNames.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurvedAppBar(title: "Projects", height: 110),
      body: Column(
        children: [
          Center(
            child: IconButton(
              onPressed: () {
                _logout(context);
              },
              icon: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
    );
  }
}
