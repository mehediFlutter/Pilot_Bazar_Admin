import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';

class MyTextFromFild extends StatelessWidget {
  final TextEditingController myController;
  final String hintText;
  final String validatorText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget icon;

  const MyTextFromFild({
    super.key,
    required this.hintText,
    required this.validatorText,
    required this.myController,
    required this.keyboardType,
    this.obscureText = false,
    this.icon = const SizedBox(),
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      style: loginRegistrationHintTextStyle,
      controller: myController,
      cursorColor: Colors.black,
      cursorWidth: 1,
      obscureText: obscureText,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
          suffixIcon: icon),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return validatorText;
        }
        return null;
      },
    );
  }
}
