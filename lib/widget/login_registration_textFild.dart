import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';

class MyTextFromFild extends StatelessWidget {
  final TextEditingController myController;
  final String hintText;
  final String validatorText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget icon;
  final Widget prefixIcon;

  const MyTextFromFild({
    super.key,
    required this.hintText,
    required this.validatorText,
    required this.myController,
    required this.keyboardType,
    this.obscureText = false,
    this.icon = const SizedBox(),
    this.prefixIcon = const SizedBox(),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      height: 40,
      child: TextFormField(
        keyboardType: keyboardType,
        style: TextStyle(color: Color(0xFF444444), fontSize: 18, height: 0),
        controller: myController,
        cursorColor: Color(0xFFA6A6A6),
        cursorWidth: 1,
        obscureText: obscureText,
        decoration: InputDecoration(
          // isDense: true,
          hintText: hintText,
          hintStyle:
              TextStyle(color: Color(0xFF444444), fontSize: 18, height: 0),
          suffixIcon: icon,
          prefixIcon: prefixIcon,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFA6A6A6)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFA6A6A6), width: 2.0),
          ),
        ),
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return validatorText;
          }
          return null;
        },
      ),
    );
  }
}
