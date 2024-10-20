import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/socket_io/socket_manager.dart';

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
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  showAlertDialogServer(BuildContext context, String text, errorText) {
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
                  onPressed: () async {
                    await SocketManager();
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text(
                    errorText,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  logOutDialog(
    BuildContext context,
    String content,
    yesText,
    noText,
    Function() logoutFunction,
    // Function() cancelFunction,
  ) {
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
              content,
              style: small14StyleW500.copyWith(fontSize: 15),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      logoutFunction(); // Close the dialog
                    },
                    child: Text(
                      yesText,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text(
                      noText,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
