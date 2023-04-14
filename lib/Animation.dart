import 'package:flutter/material.dart';

class AnimatedRowScrolling extends StatefulWidget {
  @override
  _AnimatedRowScrollingState createState() => _AnimatedRowScrollingState();
}

class _AnimatedRowScrollingState extends State<AnimatedRowScrolling>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final double _containerWidth = 100.0;
  final double _spacing = 16.0;
  final double _animationDuration = 1.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: _animationDuration.toInt()),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _containerWidth,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            return Row(
              children: List.generate(
                10,
                (index) {
                  final animationValue = (_controller.value + index / 10) % 1.0;

                  return Padding(
                    padding: EdgeInsets.only(right: _spacing),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: _containerWidth,
                      height: _containerWidth,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      transform: Matrix4.translationValues(
                        -animationValue * _containerWidth,
                        0,
                        0,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
