import 'package:flutter/material.dart';

class Location extends StatelessWidget {
  final String available;
  const Location({
    super.key, required this.available,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Icons.location_on,
          size: 16,
        ),
        Text(
          available,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
