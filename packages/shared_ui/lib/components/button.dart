import 'package:flutter/material.dart';

import '../shared_ui.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({this.onPressed, super.key});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: greenButtonStyle,
      child: Text(
        'Login',
        style: normalWhiteTextStyle,
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({this.onPressed, super.key});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: greenButtonStyle,
      child: Text(
        'Submit',
        style: normalWhiteTextStyle,
      ),
    );
  }
}

class BackToLoginButton extends StatelessWidget {
  const BackToLoginButton({this.onPressed, super.key});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: greenButtonStyle,
      child: Text(
        'Back To Login',
        style: normalWhiteTextStyle,
      ),
    );
  }
}

class BackToLoginTextButton extends StatelessWidget {
  const BackToLoginTextButton({this.onPressed, super.key});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        'Back To Login',
        style: normalGreenTextStyle,
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({this.onPressed, super.key});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: greenButtonStyle,
      child: Text(
        'Save',
        style: normalWhiteTextStyle,
      ),
    );
  }
}

class ChangePasswordButton extends StatelessWidget {
  const ChangePasswordButton({this.onPressed, super.key});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: greenButtonStyle,
      child: Text(
        'Change Password',
        style: normalWhiteTextStyle,
      ),
    );
  }
}

class ChangePasswordTextButton extends StatelessWidget {
  const ChangePasswordTextButton({this.onPressed, super.key});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        'Change Password',
        style: normalGreenTextStyle,
      ),
    );
  }
}

class ForgotPasswordTextButton extends StatelessWidget {
  const ForgotPasswordTextButton({this.onPressed, super.key});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        'Forgot Password?',
        style: normalGreenTextStyle,
      ),
    );
  }
}

class EditPhotoTextButton extends StatelessWidget {
  const EditPhotoTextButton({this.onPressed, super.key});
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        'Edit Photo',
        style: normalGreenTextStyle,
      ),
    );
  }
}

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({
    Key? key,
    this.onPress,
    this.style,
  }) : super(key: key);
  final void Function()? onPress;
  final ButtonStyle? style;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: style,
      child: Text(
        'Confirm',
        style: normalWhiteTextStyle,
      ),
    );
  }
}

class CancelBookingButton extends StatelessWidget {
  const CancelBookingButton({required this.onPress, super.key, this.textCancel});
  final String? textCancel;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: redButtonStyle,
      child: Text(
        textCancel ?? '',
        style: normalWhiteTextStyle,
      ),
    );
  }
}

class BackToHomeTextButton extends StatelessWidget {
  const BackToHomeTextButton({required this.onPress, super.key});
  final void Function()? onPress;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: greenButtonStyle,
      child: Text(
        'Back to Home',
        style: normalWhiteTextStyle,
      ),
    );
  }
}
