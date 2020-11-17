import 'package:flutter/material.dart';

class SlideDots extends StatelessWidget {
  final bool isActive;

  SlideDots(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      height: isActive ? 12.0 : 8.0,
      width: isActive ? 12.0 : 8.0,
      decoration: BoxDecoration(
          color: isActive ? Theme.of(context).primaryColor : Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
    );
  }
}
