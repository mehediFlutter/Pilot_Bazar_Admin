import 'package:flutter/material.dart';

class MyTextFromFild extends StatefulWidget {
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
  State<MyTextFromFild> createState() => _MyTextFromFildState();
}

class _MyTextFromFildState extends State<MyTextFromFild> {
  bool isError = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      style: const TextStyle(color: Color(0xFF444444), fontSize: 18, height: 0),
      controller: widget.myController,
      cursorColor: const Color(0xFFA6A6A6),
      cursorWidth: 1,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 15),
        hintText: widget.hintText,
        hintStyle:
            const TextStyle(color: Color(0xFF444444), fontSize: 18, height: 0),
        suffixIcon: widget.icon,
        prefixIcon: widget.prefixIcon,
        focusedBorder: const UnderlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFA6A6A6), width: 2.0),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide:
              BorderSide(color: Colors.red), // Define error border style
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFA6A6A6)),
        ),
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          isError = true;
          setState(() {});

          return widget.validatorText;
        }
        isError = false;
        setState(() {});
        return null;
      },
    );
  }
}
