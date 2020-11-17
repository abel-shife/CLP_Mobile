import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    @required this.imageUrl,
    @required this.title,
    @required this.description
  });
  static final slideList = [
    Slide(
        imageUrl: 'assets/images/image1.jpg',
        title: 'Cool way to get started',
        description: 'the simples and coolest way...liklike u\'ve never seen before'
    ),
    Slide(
        imageUrl: 'assets/images/image2.jpg',
        title: 'fast and secured',
        description: 'the simples and coolest way...liklike u\'ve never seen before'
    ),
    Slide(
        imageUrl: 'assets/images/image3.jpg',
        title: 'easy and simple',
        description: 'the simples and coolest way...liklike u\'ve never seen before'
    )
  ];
}
