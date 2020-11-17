import 'package:flutter/material.dart';

LinearGradient getLinearGradient() {
  return LinearGradient(begin: Alignment.topCenter, colors: [
    Colors.blue[800],
    Colors.blue[600],
    Colors.blue[200],
  ]);
}

BoxShadow getBoxShadowProperty() {
  return BoxShadow(
    color: Colors.blue[200],
    blurRadius: 1.0, // soften the shadow
    spreadRadius: 2.0, //extend the shadow
    offset: Offset(
      1.0, // Move to right 10  horizontally
      1.0, // Move to bottom 5 Vertically
    ),
  );
}

LinearGradient getImageGradient() {
  return LinearGradient(begin: Alignment.bottomRight, stops: [0.2, 0.8,1], colors: [
    Colors.black.withOpacity(.7),
    Colors.black.withOpacity(.5),
    Colors.black.withOpacity(.2),
  ]);
}

BoxDecoration getElevationProperty(){
  return BoxDecoration(
    boxShadow: [
      BoxShadow(
          blurRadius: 5.0,
          spreadRadius: 1.0,
          color: Colors.grey.shade400)
    ],
    borderRadius: BorderRadius.circular(10.0),
    color: Colors.grey.shade200,
  );
}