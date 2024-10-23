import 'package:flutter/material.dart';

class LoginTextFieldUpperText extends StatelessWidget {
  const LoginTextFieldUpperText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        "Phone Number",
        style: TextStyle(color: Color(0xFF344054), fontSize: 14,fontWeight: FontWeight.w500),
      ),
    );
  }
}