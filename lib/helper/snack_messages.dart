import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

void showSuccessSnackbar(BuildContext context, String title, String message) {
  final snackbar = SnackBar(
    duration: const Duration(seconds: 4),
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: ContentType.success,
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

void showErrorSnackbar(BuildContext context, String title, String message) {
  final snackbar = SnackBar(
    duration: const Duration(seconds: 4),
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: ContentType.success,
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
