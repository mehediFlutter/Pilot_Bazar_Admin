import 'package:flutter/material.dart';

class NewNameTextFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType keyboardType;
  final String validatorText;

  const NewNameTextFormField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    required this.validatorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: textEditingController,
      decoration: InputDecoration(
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
