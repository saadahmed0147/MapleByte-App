import 'package:flutter/material.dart';
import 'package:maple_byte/Component/round_button.dart';
import 'package:maple_byte/Route/route_names.dart';
import 'package:maple_byte/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: mq.height * 0.6,
            width: double.infinity,
            child: Image.asset("assets/images/logo.png"),
          ),
          Padding(
            padding: const EdgeInsets.all(70),
            child: RoundButton(
              title: "Get Started!",
              fontFamily: "Baloo2",
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              borderRadius: 50,
              onPress: () {
                Navigator.pushNamed(context, RouteNames.detailSplashScreen);
              },
            ),
          ),
        ],
      ),
    );
  }
}
