import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final List<Widget> children;
  const CustomButton({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: children,
    );
  }
}