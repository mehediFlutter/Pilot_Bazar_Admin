import 'package:flutter/material.dart';

class ScreenImage extends StatelessWidget {
  const ScreenImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset("assets/images/new_vehicle_demo.png")),
    );
  }
}

