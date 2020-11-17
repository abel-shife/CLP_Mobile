import 'package:cached_network_image/cached_network_image.dart';
import 'package:finalloyal/models/client_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class FeedBack extends StatefulWidget {
  final Client client;

  FeedBack({this.client});

  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.client == null
            ? Text('Feedback')
            : Text(widget.client.firstName + " " + widget.client.lastName),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ClipPath(
            child: Container(
              color: Theme.of(context).primaryColor.withOpacity(0.5),
              height: 100,
            ),
            clipper: WaveClipperOne(),
          ),
          ClipPath(
            child: Container(
              color: Theme.of(context).primaryColor,
              height: 100,
            ),
            clipper: WaveClipperTwo(),
          ),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: Text(
                  'Please Give Your Feedback for better Experience.',
                  style: TextStyle(fontSize: 20.0, color: Colors.white70),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Text(
                'Feedback',
                style: TextStyle(
                    fontSize: 24, color: Theme.of(context).primaryColor),
              ),
              Expanded(
                child: ListView(
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 16.0),
                      child: TextField(
                        minLines: 5,
                        maxLines: 5,
                        decoration: InputDecoration(
                            hintText: 'Your give your comments here',
                            fillColor: Theme.of(context).primaryColor.withOpacity(0.5),
                            filled: true),
                      ),
                    ),
                    Padding(
                      padding:  const EdgeInsets.symmetric(vertical:8.0, horizontal: 16.0),
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(50.0)),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: Text(
                          'Send Comment',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
//      body: ListView(
//        children: <Widget>[
//          Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: Column(
//              children: <Widget>[
//                Text(
//                  'Please Give Your Feedback for better service..',
//                  style: TextStyle(fontSize: 28.0, color: Theme.of(context).primaryColor),
//                ),
//                SizedBox(
//                  height: 15.0,
//                ),
//                Text(
//                  'Your feedback is very important for us to improve our service and make changes.',
//                  style: TextStyle(fontSize: 18.0, color: Theme.of(context).primaryColor),
//                ),
//                Container(
//                  margin: EdgeInsets.only(top: 10.0),
//                  height: 2.0,
//                  width: double.infinity,
//                  color: Theme.of(context).primaryColor,
//                ),
//                Card(
//                  color: Theme.of(context).primaryColorDark,
//                  child: Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Column(
//                      children: <Widget>[
//                        Text(
//                          'The system made the hotel easy and interesting to use ?',
//                          style: TextStyle(
//                              fontSize: 18.0, color: Theme.of(context).primaryColor),
//                        ),
//                        SizedBox(
//                          height: 15.0,
//                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceAround,
//                          children: <Widget>[
//                            IconButton(
//                              icon: Icon(
//                                Icons.thumb_up,
//                                color: Colors.white70,
//                              ),
//                              onPressed: () {},
//                            ),
//                            IconButton(
//                              icon: Icon(
//                                FontAwesomeIcons.meh,
//                                color: Colors.white70,
//                              ),
//                              onPressed: () {},
//                            ),
//                            IconButton(
//                              icon: Icon(
//                                Icons.thumb_down,
//                                color: Colors.white70,
//                              ),
//                              onPressed: () {},
//                            )
//                          ],
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//                SizedBox(
//                  height: 15.0,
//                ),
//                Card(
//                  color: Theme.of(context).primaryColorDark,
//                  child: Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Column(
//                      children: <Widget>[
//                        Text(
//                          'Please Leave a comment ?',
//                          style: TextStyle(
//                              fontSize: 18.0, color: Colors.white70),
//                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: <Widget>[
//                            Text(
//                              'In Which Type?',
//                              style: TextStyle(
//                                  fontSize: 18.0, color: Colors.white70),
//                            ),
//                            Container(
//                              width:
//                                  MediaQuery.of(context).size.width / 2 - 10,
//                              child: DropdownButton(
//                                isExpanded: true,
//                                items: feedbackType.map((String item) {
//                                  return DropdownMenuItem<String>(
//                                    value: item,
//                                    child: (Text(
//                                      item,
//                                      style: TextStyle(
//                                        fontSize: 18.0,
//                                      ),
//                                    )),
//                                  );
//                                }).toList(),
//                                onChanged: (value) {},
//                                value: feedbackType[0],
//                              ),
//                            ),
//                          ],
//                        ),
//                        TextField(
//                          minLines: 5,
//                          maxLines: 5,
//                          decoration: InputDecoration(
//                              hintText: 'Your Feedback here',
//                              fillColor: Colors.white70,
//                              filled: true),
//                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.end,
//                          children: <Widget>[
//                            RaisedButton(
//                              padding: EdgeInsets.symmetric(
//                                vertical: 10.0,
//                              ),
//                              shape: RoundedRectangleBorder(
//                                  borderRadius: BorderRadius.circular(50.0)),
//                              color: Theme.of(context).primaryColor,
//                              textColor: Colors.white,
//                              child: Text(
//                                'Send',
//                                style: TextStyle(fontSize: 18.0),
//                              ),
//                              onPressed: () {},
//                            )
//                          ],
//                        ),
//                      ],
//                    ),
//                  ),
//                )
//              ],
//            ),
//          )
//        ],
//      ),
    );
  }
}
