import 'package:finalloyal/models/getting_started.dart';
import 'package:flutter/material.dart';

class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          //the image
          width: 200,
          height: 200,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage(Slide.slideList[index].imageUrl),
                  fit: BoxFit.cover)),
        ),
        SizedBox(height: 30.0,),
        Text(
          Slide.slideList[index].title,
          style: TextStyle(
              fontSize: 22.0, color: Colors.white),
        ),
        SizedBox(height: 10.0,),
        Text(
          Slide.slideList[index].description,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white),
        ),
      ],
    );
  }
}
