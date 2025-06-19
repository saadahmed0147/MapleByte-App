import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maple_byte/Route/route_names.dart';
import 'package:maple_byte/Utils/app_colors.dart';
import 'package:maple_byte/main.dart';

class DetailedSplash extends StatefulWidget {
  const DetailedSplash({super.key});

  @override
  State<DetailedSplash> createState() => _DetailedSplashState();
}

class _DetailedSplashState extends State<DetailedSplash> {
  @override
  void initState() {
    super.initState();

    // Navigate after 3 seconds
    Timer(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
      // Or navigate to RouteNames.todoScreen if already logged in
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(),
              child: SizedBox(
                height: mq.height * 0.5,
                width: double.infinity,
                child: Image.asset(
                  "assets/images/splash-image.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: mq.height * 0.3,
              width: double.infinity,
              child: Image.asset("assets/images/logo.png"),
            ),
            SizedBox(
              height: mq.height * 0.2,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "We're a full-service marketing agency that blends technical expertise with creative innovation to deliver exceptional results for our clients.",
                  style: TextStyle(
                    fontFamily: "Baloo2",
                    fontSize: 20,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
