import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final Color color;
  final double progress;
  final double angle;
  final double sweepAngle;
  final Offset center;
  CirclePainter(
      {Key? key,
      required this.color,
      required this.progress,
      required this.angle,
      required this.center,
      required this.sweepAngle});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.height;
    var path = Path();
    double degToRad(double deg) => deg * (pi / 180.0);
    path.arcTo(
        Rect.fromCenter(
          center: center,
          height: 140,
          width: 140,
        ),
        degToRad(angle),
        degToRad(sweepAngle),
        false);

    PathMetrics pathMetrics = path.computeMetrics();
    for (PathMetric pathMetric in pathMetrics) {
      Path extractPath = pathMetric.extractPath(
        0.0,
        pathMetric.length * progress,
      );
      canvas.drawPath(extractPath, paint);
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return false;
  }
}
