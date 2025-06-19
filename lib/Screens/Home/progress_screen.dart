import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maple_byte/Route/route_names.dart';
import 'package:maple_byte/Utils/app_colors.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  Widget build(BuildContext context) {
    Future<void> _confirmLogout() async {
      final shouldLogout = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Logout'),
            ),
          ],
        ),
      );

      if (shouldLogout == true) {
        await FirebaseAuth.instance.signOut();
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightBlueColor,
        actions: [
          IconButton(
            onPressed: () {
              _confirmLogout();
            },
            icon: Icon(Icons.exit_to_app, color: AppColors.whiteColor),
          ),
        ],
      ),
    );
  }
}
