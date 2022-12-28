import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../utilities/shared_preferences/shared_preferences.dart';
import '../login/login_screen.dart';
import '../navigator/navigator_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    countDownTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        ImagePath.splashScreen.assetName,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  countDownTime() async {
    return Timer(
      const Duration(seconds: 1),
      () async {
        if (await getToken() != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (BuildContext context) => const NavigatorScreen()),
              (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()),
              (route) => false);
        }
      },
    );
  }
}
