import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Curved Arrow Example'),
      ),
      body: Center(
        child: CustomPaint(
          size: Size(100, 100),
          painter: CurvedArrowPainter(),
        ),
      ),
    ),
  ));
}

class CurvedArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    Path path = Path();
    path.moveTo(200, 10); 
    path.quadraticBezierTo(100, 100, 200, 50); 

    canvas.drawPath(path, paint);

    // Draw arrowhead at the end of the curve
    double arrowSize = 10;
    canvas.drawLine(Offset(180 - arrowSize, 100 - arrowSize), Offset(180, 100), paint);
    canvas.drawLine(Offset(180 + arrowSize, 100 - arrowSize), Offset(180, 100), paint);
  }

  @override
  bool shouldRepaint(CurvedArrowPainter oldDelegate) {
    return false;
  }
}
