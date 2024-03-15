import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';

class DividerWithCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Divider(
          color: searchBarBorderColor, // Customize the color of the divider
          thickness: 1, // Adjust the thickness of the divider
        ),
        Positioned(
          child: Align(
            alignment: Alignment.center,
            child: Container(
            
              width: 15, // Adjust the size of the circle
              height: 15, // Adjust the size of the circle
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: searchBarBorderColor)
               // Customize the color of the circle
              ),
            ),
          ),
        ),
      ],
    );
  }
}
