import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:math';

class GoalEffect extends StatefulWidget {
  @override
  _GoalEffectState createState() => new _GoalEffectState();
}

class _GoalEffectState extends State<GoalEffect>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Animation<double> _fadeAnimation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.8,
          1,
          curve: Curves.easeOut,
        ),
      ),
    );

    return FadeTransition(
        opacity: _fadeAnimation,
        child: Stack(
          children: List(20).map((_) => _RandomEmoji(_controller)).toList(),
        ));
  }
}

class _RandomEmoji extends StatelessWidget {
  final AnimationController _controller;
  final Random random = Random();

  _RandomEmoji(this._controller);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double left = random.nextDouble() * size.width;
    final double bottom = random.nextDouble() * -800.0;
    final double fontSize = random.nextDouble() * 50.0 + 10.0;

    Animation<RelativeRect> _rectAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(
        left,
        0.0,
        0.0,
        bottom - 50,
      ),
      end: RelativeRect.fromLTRB(
        left,
        -800.0,
        0.0,
        bottom + 800.0,
      ),
    ).animate(_controller);

    return PositionedTransition(
      rect: _rectAnimation,
      child: Container(
        alignment: AlignmentDirectional.bottomStart,
        child: Text(
          '🎉',
          style: TextStyle(fontSize: fontSize),
        ),
      ),
    );
  }
}
