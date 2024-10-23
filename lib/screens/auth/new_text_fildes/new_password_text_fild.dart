import 'package:flutter/material.dart';

class NewPasswordTextFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final String validatorText;

  final Widget icon;
  final bool obscureText;
  const NewPasswordTextFormField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.icon,
    required this.obscureText,
    required this.validatorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: icon,
        hintText: hintText,
        hintStyle: TextStyle(color: Color(0xFF667085)),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD0D5DD)),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD0D5DD)),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD0D5DD)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return validatorText;
        }

        return null;
      },
    );
  }
}
