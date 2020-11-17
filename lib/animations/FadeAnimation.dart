import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween()
      ..add('opacity', Tween(begin: 0.0, end: 1.0), Duration(milliseconds: 500))
      ..add('translateY', Tween(begin: 120.0, end: 1.0),
          Duration(milliseconds: 500));

    return CustomAnimation(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get('opacity'),
        child: Transform.translate(
          offset: Offset(
            0,
            value.get('translateY'),
          ),
          child: child,
        ),
      ),
    );
  }
}

//class FadeAnimation extends StatefulWidget {
//  final double delay;
//  final Widget child;
//
//  FadeAnimation(this.delay, this.child);
//
//  @override
//  _FadeAnimationState createState() => _FadeAnimationState();
//}
//
//class _FadeAnimationState extends State<FadeAnimation> with SingleTickerProviderStateMixin{
//  AnimationController controller;
//  Animation animation;
//
//  @override
//  void initState() {
//    super.initState();
//    controller=AnimationController(vsync: this,duration: Duration(seconds: 2));
//    animation=Tween(begin: 0.0,end: 1.0).animate(controller);
//  }
//
//  @override
//  void dispose() {
//    controller.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    controller.forward();
//    return FadeTransition(
//      opacity: animation,
//      child: widget.child,
//    );
//  }
//}
