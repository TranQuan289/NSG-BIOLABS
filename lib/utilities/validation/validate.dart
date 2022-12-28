String validateEmail(String email) {
  if (email.trim().isEmpty) {
    return 'Email address is required.';
  } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email)) {
    return 'Invalid email address';
  } else {
    return '';
  }
}

String validatePassword(String password) {
  if (password.trim().isEmpty) {
    return 'Password is required.';
  } else {
    return '';
  }
}

String validateUpdatePassword(
    {required String currentPassword,
    required String newPassword,
    required String newPasswordConfirmation}) {
  if (currentPassword.trim().isEmpty) {
    return 'Current password is required. ';
  } else if (newPassword.trim().isEmpty) {
    return 'New password is required.';
  } else if (newPassword.trim().length < 8) {
    return 'New password must be at least 8 characters';
  } else if (newPasswordConfirmation.trim().isEmpty) {
    return 'Confirm password is required.';
  } else if (newPassword != newPasswordConfirmation) {
    return 'Confirm password must be match new password';
  } else {
    return '';
  }
}

String validateName(String name) {
  if (name.trim().isEmpty) {
    return 'Name is required.';
  } else {
    return '';
  }
}


