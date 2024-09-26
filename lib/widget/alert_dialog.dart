import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';

class CustomAlertDialog {
  showAlertDialog(BuildContext context, String text, errorText) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // contentPadding: EdgeInsets.zero,
          elevation: 50,
          shadowColor: Colors.black,
          backgroundColor: Colors.white,
          content: Padding(
            padding: const EdgeInsets.only(left: 10, top: 20),
            child: Text(
              text,
              style: small14StyleW500.copyWith(fontSize: 15),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text(
                    errorText,
                    style: const TextStyle(color: Colors.green),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
