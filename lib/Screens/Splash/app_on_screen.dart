import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maple_byte/Route/route_names.dart';
import 'package:maple_byte/Services/splash_services.dart';
import 'package:maple_byte/Utils/app_colors.dart';
import 'package:maple_byte/main.dart';

class AppOnScreen extends StatefulWidget {
  const AppOnScreen({super.key});

  @override
  State<AppOnScreen> createState() => _AppOnScreenState();
}

class _AppOnScreenState extends State<AppOnScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      SplashServices().checkAppStartState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          height: mq.height * 0.25,
          width: mq.width * 0.25,
        ),
      ),
    );
  }
}
