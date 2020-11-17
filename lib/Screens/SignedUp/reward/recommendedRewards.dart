import 'package:flutter/material.dart';

class RecommendedRewards extends StatefulWidget {
  @override
  _RecommendedRewardsState createState() => _RecommendedRewardsState();
}

class _RecommendedRewardsState extends State<RecommendedRewards> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.black,
                child: Container(
                  height: 150.0,
                  width: MediaQuery.of(context).size.width - 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Reward Name',
                                  style: TextStyle(color: Colors.pink, fontSize: 18.0),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'Reward Subtitle',
                                  style: TextStyle(color: Colors.pink, fontSize: 14.0),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '20',
                                  style: TextStyle(color: Colors.pink, fontSize: 18.0),
                                ),
                                Text(
                                  'points needed',
                                  style: TextStyle(color: Colors.pink, fontSize: 14.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(50.0)),
                          color: Colors.pink,
                          onPressed: () {},
                          child: Text(
                            'Redeem',
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ))));
  }
}
