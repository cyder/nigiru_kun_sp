import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CircularBar extends StatelessWidget {
  final double percent;
  final Widget center;
  final Color progressColor;
  final Color backgroundColor;

  CircularBar({
    this.percent,
    this.center,
    this.progressColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return CircularPercentIndicator(
      radius: size.width * 0.8,
      lineWidth: 30.0,
      animation: false,
      circularStrokeCap: CircularStrokeCap.round,
      percent: percent,
      center: center,
      progressColor: progressColor,
      backgroundColor: backgroundColor,
    );
  }
}
