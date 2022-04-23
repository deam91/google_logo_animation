import 'package:flutter/material.dart';
import 'package:google_animation/widgets/blue_circle.dart';
import 'package:google_animation/widgets/red_circle.dart';

import 'green_circle.dart';
import 'orange_circle.dart';

class AnimationArea extends StatefulWidget {
  const AnimationArea({Key? key}) : super(key: key);

  @override
  State<AnimationArea> createState() => _AnimationAreaState();
}

class _AnimationAreaState extends State<AnimationArea>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;
  late AnimationController _controller4;

  late final Animation offset;
  late final Animation<double> tween;

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5500));
    _controller1.forward();

    _controller2 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5500));
    _controller2.forward();

    _controller3 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5500));
    _controller3.forward();

    _controller4 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5500));
    _controller4.forward();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 390,
          child: LayoutBuilder(builder: (context, constraints) {
            final circleLeft = (constraints.maxWidth) / 6;
            final top = constraints.maxHeight / 2.5;
            return Stack(
              children: [
                Positioned(
                  top: top,
                  width: circleLeft,
                  left: circleLeft * 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RedCircle(
                        size: circleLeft,
                        color: Colors.red,
                        controller: _controller2,
                        startAt: 0.03,
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: top,
                  width: circleLeft,
                  left: circleLeft * 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OrangeCircle(
                        size: circleLeft,
                        color: Colors.orangeAccent,
                        controller: _controller3,
                        startAt: 0.06,
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: top,
                  width: circleLeft,
                  left: circleLeft * 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GreenCircle(
                        size: circleLeft,
                        color: Colors.green,
                        controller: _controller4,
                        startAt: 0.09,
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: top,
                  width: circleLeft,
                  height: 30,
                  left: circleLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlueCircle(
                        size: circleLeft,
                        color: Colors.blue,
                        controller: _controller1,
                        startAt: 0.0,
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
