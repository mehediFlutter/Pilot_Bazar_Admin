import 'package:flutter/material.dart';
import 'package:arrow_path/arrow_path.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('90-Degree Curved Arrow Example'),
      ),
      body: Center(
        child: CustomPaint(
          size: Size(200, 200),
          painter: CurvedArrowPainter(
            // Customize these properties for different arrow styles
            color: Colors.blue,
            strokeWidth: 5.0,
          ),
        ),
      ),
    ),
  ));
}

class CurvedArrowPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  CurvedArrowPainter({this.color = Colors.blue, this.strokeWidth = 5.0});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(50, 50) // Start point
      ..relativeQuadraticBezierTo(50, 0, 100, 50) // Curve to the right
      ..relativeLineTo(0, 50) // Line down
      ..relativeQuadraticBezierTo(-50, 0, -50, -50) // Curve to the left
      ..close(); // Close the path to form the arrow shape

    final paint = Paint()
      ..color = color // Use the provided color
      ..strokeWidth = strokeWidth // Use the provided stroke width
      ..style = PaintingStyle.stroke; // Draw only the outline

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CurvedArrowPainter oldDelegate) => false;
}