import 'package:flutter/material.dart';

class TextFieldForName extends StatefulWidget {
  final TextEditingController myController;
  final String validatorText;
  final String hintText;
  final Widget prefixIcon;


  const TextFieldForName({
    super.key,
    required this.validatorText,
    required this.myController,
    this.prefixIcon = const SizedBox(), required this.hintText,
  });

  @override
  State<TextFieldForName> createState() => _TextFieldForNameState();
}

class _TextFieldForNameState extends State<TextFieldForName> {
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:widget.myController,
      keyboardType: TextInputType.text,
      style: const TextStyle(color: Color(0xFF444444), fontSize: 18, height: 0),
      cursorColor: const Color(0xFFA6A6A6),
      cursorWidth: 1,
      decoration: InputDecoration(
        
        contentPadding: EdgeInsets.only(top: 15),
        hintText: widget.hintText,
        hintStyle:
            const TextStyle(color: Color(0xFF444444), fontSize: 18, height: 0),
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
