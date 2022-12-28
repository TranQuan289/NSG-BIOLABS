import 'package:codebase/screens/navigator/navigator_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

class SuccessBookingScreen extends StatefulWidget {
  const SuccessBookingScreen({super.key});

  @override
  State<SuccessBookingScreen> createState() => _SuccessBookingScreenState();
}

class _SuccessBookingScreenState extends State<SuccessBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_sharp,
                color: greenColor,
                size: 65,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Booking Success',
                style: TextStyle(
                  color: blackColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Your booking has been confirmed',
                style: TextStyle(
                  color: blackColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: 369,
                height: 48,
                child: BackToHomeTextButton(
                  onPress: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const NavigatorScreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
