import 'package:flutter/material.dart';

class SnackbarUtils {
  // Function to show Snackbar
  static void showSnackbar(
    BuildContext context,
    String message, {
    Color? backgroundColor,   
    Color? textColor,
  }) {
    backgroundColor ??= Colors.white;

    textColor ??= Colors.black;

    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: backgroundColor,
    );

    // Showing the Snackbar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
