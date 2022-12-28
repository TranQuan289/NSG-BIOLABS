import 'package:flutter/material.dart';
import 'package:shared_ui/shared_ui.dart';

import '../login/login_screen.dart';

class ForgotPasswordSubmitScreen extends StatelessWidget {
  const ForgotPasswordSubmitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HeaderLogin(),
            Column(
              children: [
                const SizedBox(height: 100),
                Icon(
                  Icons.check_circle_rounded,
                  color: greenColor,
                  size: 65.0,
                ),
                const SizedBox(height: 20),
                Text(
                  'Submitted',
                  style: titleboldTextStyle,
                ),
                const SizedBox(height: 8),
                Text(
                  'Check your email for further instructions',
                  style: normalBlackTextStyle,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: BackToLoginButton(
                onPressed: () => backToLogin(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  backToLogin(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
