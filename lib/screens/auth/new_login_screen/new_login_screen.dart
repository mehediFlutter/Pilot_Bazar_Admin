import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/screens/auth/new_login_screen/Login_text_fild_upper_text.dart';

class NewLoginScreen extends StatefulWidget {
  const NewLoginScreen({super.key});

  @override
  State<NewLoginScreen> createState() => _NewLoginScreenState();
}

class _NewLoginScreenState extends State<NewLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoginTextFieldUpperText(),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter Your Phone Number',
              hintStyle: TextStyle(color: Color(0xFF667085)),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
          )
        ],
      ),
    ));
  }
}


