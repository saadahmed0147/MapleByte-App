import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maple_byte/Screens/Home/progress_screen.dart';
import 'package:maple_byte/Screens/Messages/users_screen.dart';
import 'package:maple_byte/Screens/news_screen.dart';
import 'package:maple_byte/Screens/quotes_screen.dart';
import 'package:maple_byte/Screens/services_screen.dart';
import 'package:maple_byte/Utils/app_colors.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final iconList = <IconData>[
    Icons.home,
    Icons.miscellaneous_services,
    Icons.message,
    Icons.newspaper_rounded,
    Icons.format_quote_sharp,
  ];

  final labels = <String>["Home", "Services", "Messages", "News", "Quotes"];
  int _currentIndex = 0;

  late String currentUserId;
  late List<Widget> screens;

  @override
  void initState() {
    super.initState();

    // ✅ Get current user
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUserId = user.uid;
    } else {
      // Optional: handle unauthenticated state
      currentUserId = 'guest';
    }

    // ✅ Build screens list after getting user ID
    screens = [
      ProgressScreen(),
      ServicesScreen(),
      UsersScreen(currentUserId: currentUserId),
      NewsScreen(),
      QuotesScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: screens),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomAppBar(
            color: AppColors.darkBlueColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(5, (index) {
                final isSelected = _currentIndex == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: isSelected
                          ? BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            )
                          : BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.darkBlueColor,
                                width: 2,
                              ),
                            ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(iconList[index], size: 26, color: Colors.white),
                          const SizedBox(height: 2),
                          Text(
                            labels[index],
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
