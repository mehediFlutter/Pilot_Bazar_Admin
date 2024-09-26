import 'dart:math' as math;

import 'package:arrow_path/arrow_path.dart';
import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Arrow Path Example',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const ExampleApp(),
      );
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Arrow Path Example'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Icon(
                Icons.subdirectory_arrow_right_rounded,
                color: syncIconColor,
              ),
              ClipRect(
                child: CustomPaint(
                  size: Size(MediaQuery.of(context).size.width, 700),
                  painter: ArrowPainter(),
                ),
              ),
            ],
          ),
        ),
      );
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    /// The arrows usually looks better with rounded caps.
    final Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 3.0;

    /// Draw a single arrow.
    {
      Path path = Path();
      path.moveTo(size.width * 0.25, 60);
      path.relativeCubicTo(0, 0, 20 * 20, 20, 10 * 10, 10);
      path = ArrowPath.addTip(path);

      canvas.drawPath(path, paint..color = Colors.blue);

      const TextSpan textSpan = TextSpan(
        text: 'Single arrow',
        style: TextStyle(color: Colors.blue),
      );
      final TextPainter textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(minWidth: size.width);
      textPainter.paint(canvas, const Offset(0, 36));
    }

    /// Draw a double sided arrow.
  }

  @override
  bool shouldRepaint(ArrowPainter oldDelegate) => false;
}
