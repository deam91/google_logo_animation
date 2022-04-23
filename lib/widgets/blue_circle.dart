import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'circle_painter.dart';

class BlueCircle extends StatelessWidget {
  final double startAt;
  final Color color;
  final double size;
  final AnimationController controller;

  BlueCircle(
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
        translationRight = Tween(begin: 0.0, end: size * 2).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.6,
              0.8,
              curve: Curves.ease,
            ),
          ),
        ),
        width = Tween(begin: 30.0, end: size).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.6,
              0.8,
              curve: Curves.ease,
            ),
          ),
        ),
        borderRadiusLeft = Tween(begin: 15.0, end: 0.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.75,
              0.8,
              curve: Curves.ease,
            ),
          ),
        ),
        borderRadiusRight = Tween(begin: 15.0, end: 0.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.6,
              0.8,
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
  final Animation<double> translationRight;
  final Animation<double> width;
  final Animation<double> borderRadiusLeft;
  final Animation<double> borderRadiusRight;
  final Animation<double> circle;

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Transform.translate(
      offset: Offset(translationRight.value, sizeAnimation.value),
      child: Container(
        width: width.value,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(borderRadiusLeft.value),
                right: Radius.circular(borderRadiusRight.value)),
            color: color),
        child: Align(
          alignment: Alignment.bottomRight,
          child: CustomPaint(
            size: Size(size, 30),
            painter: CirclePainter(
                center: const Offset(-18, 15),
                color: color,
                progress: circle.value * 2.5,
                angle: -10.0,
                sweepAngle: 45),
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
