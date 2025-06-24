import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maple_byte/Component/Appbar/bottom_wave_clipper.dart';
import 'package:maple_byte/Route/route_names.dart';
import 'package:maple_byte/Utils/app_colors.dart';

class CurvedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double height;
  final bool exitIcon; // 🔸 New optional flag

  const CurvedAppBar({
    super.key,
    this.title,
    this.height = 60,
    this.exitIcon = false, // 🔸 Default to false
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          ClipPath(
            clipper: BottomWaveClipper(),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [AppColors.lightBlueColor, AppColors.darkBlueColor],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 40), // Placeholder for symmetry
                  Text(
                    title ?? ' ',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  exitIcon
                      ? IconButton(
                          icon: const Icon(
                            Icons.exit_to_app_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                backgroundColor: AppColors.darkBlueColor,
                                title: const Text(
                                  'Log Out?',
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: const Text(
                                  'Are you sure you want to log out?',
                                  style: TextStyle(color: Colors.white),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(ctx).pop(false),
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                    ),
                                    onPressed: () =>
                                        Navigator.of(ctx).pop(true),
                                    child: Text(
                                      'Log Out',
                                      style: TextStyle(
                                        color: AppColors.darkBlueColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              await FirebaseAuth.instance.signOut();

                              // Show logout snackbar
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Successfully logged out'),
                                ),
                              );

                              // Navigate to login screen
                              Navigator.of(context).pushReplacementNamed(
                                RouteNames
                                    .loginScreen, // replace with your actual login route
                              );
                            }
                          },
                        )
                      : const SizedBox(width: 40), // Placeholder for layout
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
