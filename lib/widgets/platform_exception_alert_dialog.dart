import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_tracker/widgets/platform_alert_dialog.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog(
      {@required String title, @required PlatformException exception})
      : super(
          title: title,
          content: _message(exception),
          defaultActionText: 'OK',
        );

  static String _message(PlatformException exception) {
    return _errors[exception.code] ?? exception.message;
  }

  static Map<String, String> _errors = {
    'ERROR_WEAK_PASSWORD': 'Password is not strong enough',
    'ERROR_EMAIL_ALREADY_IN_USE': 'The email is already in use by another user',
    'ERROR_INVALID_EMAIL': 'The email address has formatting issues',
    'ERROR_WRONG_PASSWORD': 'The password is wrong.',
    'ERROR_USER_NOT_FOUND':
        'No user corresponding to the given email address or the user has been deleted.',
    'ERROR_USER_DISABLED': 'The user has been disabled',
    'ERROR_TOO_MANY_REQUESTS': 'Too many attempts to sign in as this user',
    'ERROR_OPERATION_NOT_ALLOWED': 'Email & Password accounts are not enabled',
  };
}
