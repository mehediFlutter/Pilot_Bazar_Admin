import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: PracticeTextfild(),
  ));
}

class PracticeTextfild extends StatelessWidget {
  const PracticeTextfild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextFormField(
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            prefix: const SizedBox(width: 50), // Adjust this width to add space
            isDense: true,
            contentPadding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
            labelText: 'Label Text',
            hintStyle:
                const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
          cursorColor: Colors.black,
          cursorWidth: 1,
        ),
      ),
    );
  }
}
