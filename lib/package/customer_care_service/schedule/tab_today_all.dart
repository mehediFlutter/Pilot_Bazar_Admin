import 'package:flutter/material.dart';

class Tabs extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Function onTap;

  const Tabs({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double underlineWidth = isSelected ? 40.0 : 0.0; // Initial underline width
    if (text == 'All') {
      underlineWidth =
          isSelected ? 20.0 : 0.0; // Update underline width for 'All' tab
    }

    return GestureDetector(
      onTap: () => onTap(),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? Colors.blue : Colors.black,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4), // Adding gap between text and underline
          Container(
            height: 2,
            width: underlineWidth, // Dynamic width for underline
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
