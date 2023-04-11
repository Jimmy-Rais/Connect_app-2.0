import 'package:flutter/material.dart';

class WidgetList extends StatefulWidget {
  @override
  _WidgetListState createState() => _WidgetListState();
}

class _WidgetListState extends State<WidgetList> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _animateOpacity();
  }

  void _animateOpacity() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn,
          child: Container(
            height: 50,
            width: 50,
            color: Colors.red,
          ),
        ),
        AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn,
          child: Container(
            height: 50,
            width: 50,
            color: Colors.blue,
          ),
        ),
        AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn,
          child: Container(
            height: 50,
            width: 50,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}
