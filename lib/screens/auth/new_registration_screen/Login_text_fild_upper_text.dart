import 'package:flutter/material.dart';

class LoginTextFieldUpperText extends StatelessWidget {
  final String? text;
  const LoginTextFieldUpperText({
    super.key,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: Text(
        text ?? '',
        style: TextStyle(
            color: Color(0xFF344054),
            fontSize: 14,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
