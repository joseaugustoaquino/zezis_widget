import 'package:flutter/material.dart';

class DotColor extends StatelessWidget {
  final double? radius;
  final Color? color;

  const DotColor({
    super.key,

    this.radius = 0.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: radius,
        height: radius,

        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}