import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Shimmer listShimmerBuilder() {
  return Shimmer.fromColors(
      baseColor: Colors.black26,
      highlightColor: Colors.white,
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.grey,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 10,
                      width: 200,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      height: 10,
                      width: 200,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      height: 10,
                      width: 100,
                      color: Colors.grey,
                    )
                  ],
                )
              ],
            ),
          );
        },
      ));
}

Column networkErrorShimmerBuilder() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.signal_cellular_off,
            size: 50.0,
          ),
          SizedBox(
            width: 20.0,
          ),
          Icon(Icons.signal_wifi_off, size: 50.0),
        ],
      ),
      SizedBox(
        height: 10.0,
      ),
      Text('Couldn\'t Connect To the The Internet'),
      SizedBox(
        height: 30.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Shimmer.fromColors(
            highlightColor: Colors.white,
            baseColor: Colors.black,
            direction: ShimmerDirection.rtl,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.arrow_back_ios,size: 30.0,),
                Text('slide t', style: TextStyle(fontSize: 16.0),),
              ],
            ),
          ),

          Shimmer.fromColors(
            highlightColor: Colors.white,
            baseColor: Colors.black,
            direction: ShimmerDirection.ltr,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('o refresh', style: TextStyle(fontSize: 16.0),),
                Icon(Icons.arrow_forward_ios,size: 30.0,),
              ],
            ),
          ),
        ],
      )
    ],
  );
}

Shimmer imagePlaceHolder() {
  return Shimmer.fromColors(
    highlightColor: Colors.white,
    baseColor: Colors.black,
    child: Container(
      color: Colors.grey,
    ),
  );
}
