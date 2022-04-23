import 'package:flutter/material.dart';
import 'package:google_animation/widgets/bezier_tween.dart';

import 'circle_painter.dart';

class RedCircle extends StatelessWidget {
  final double startAt;
  final Color color;
  final double size;
  final AnimationController controller;

  RedCircle(
      {Key? key,
      required this.color,
      required this.controller,
      required this.startAt,
      required this.size})
      : wait = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              startAt,
              curve: Curves.ease,
            ),
          ),
        ),
        sizeAnimation = TweenSequence(
          [
            TweenSequenceItem(tween: Tween(begin: 0.0, end: -15.0), weight: 1),
            TweenSequenceItem(tween: Tween(begin: -15.0, end: 15.0), weight: 1),
            TweenSequenceItem(tween: Tween(begin: 15.0, end: 0.0), weight: 1),
            TweenSequenceItem(tween: Tween(begin: 0.0, end: -15.0), weight: 1),
            TweenSequenceItem(tween: Tween(begin: -15.0, end: 15.0), weight: 1),
            TweenSequenceItem(tween: Tween(begin: 15.0, end: 0.0), weight: 1),
          ],
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              startAt,
              0.6,
              curve: Curves.ease,
            ),
          ),
        ),
        around = BezierTween(
                begin: const Offset(0, 0),
                end: Offset(size, 0),
                control: const Offset(60, -120))
            .animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.6,
              0.85,
              curve: Curves.ease,
            ),
          ),
        ),
        circle = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.8,
              1.0,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  final Animation<double> wait;
  final Animation<double> sizeAnimation;
  final Animation<double> circle;
  final Animation<Offset> around;

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Transform.translate(
      offset: around.value,
      child: Transform.translate(
        offset: Offset(0, sizeAnimation.value),
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: color),
          child: Align(
            alignment: Alignment.bottomRight,
            child: CustomPaint(
              size: Size(size, 30),
              painter: CirclePainter(
                  center: Offset(-size + size / 2 - 3, 15),
                  color: color,
                  progress: circle.value * 2.5,
                  angle: -10.0,
                  sweepAngle: 320),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: controller, builder: _buildAnimation);
  }
}
