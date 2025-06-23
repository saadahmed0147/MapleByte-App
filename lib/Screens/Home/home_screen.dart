import 'package:flutter/material.dart';
import 'package:maple_byte/Screens/Home/progress_screen.dart';
import 'package:maple_byte/Utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final iconList = <IconData>[
    Icons.home,
    Icons.miscellaneous_services,
    Icons.message,
    Icons.newspaper_rounded,
    Icons.format_quote_sharp,
  ];

  final labels = <String>["Home", "Services", "Messages", "News", "Quotes"];

  int _currentIndex = 0;

  // Dummy Screens for each tab
  final List<Widget> screens = [
    ProgressScreen(),
    Center(child: Text('Services Screen', style: TextStyle(fontSize: 24))),
    Center(child: Text('Messages Screen', style: TextStyle(fontSize: 24))),
    Center(child: Text('News Screen', style: TextStyle(fontSize: 24))),
    Center(child: Text('Quotes Screen', style: TextStyle(fontSize: 24))),
  ];

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
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      decoration: isSelected
                          ? BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            )
                          : null,
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
