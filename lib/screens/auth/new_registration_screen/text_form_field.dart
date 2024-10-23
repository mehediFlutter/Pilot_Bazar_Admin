import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class NewLoginTextFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType keyboardType;

  const NewLoginTextFormField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    this.keyboardType = TextInputType.text,
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
    );
  }
}

class NewPasswordTextFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final Widget icon;
  final bool obscureText;
  const NewPasswordTextFormField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.icon, required this.obscureText,
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
    );
  }
}

class NewPhoneNumberTextFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final String validatorText;
  
  const NewPhoneNumberTextFormField({
    super.key,
    required this.textEditingController,
    required this.hintText, required this.validatorText,
  });

  @override
  Widget build(BuildContext context) {
    var maskFormatter = new MaskTextInputFormatter(
        mask: '+88# ####-######',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
    return TextFormField(
      inputFormatters: [maskFormatter],
      controller: textEditingController,
      keyboardType: TextInputType.number,
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
