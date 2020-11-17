import 'package:finalloyal/Screens/both/event.dart';
import 'package:finalloyal/animations/FadeAnimation.dart';
import 'package:finalloyal/models/events_model.dart';
import 'package:finalloyal/properties/box_decoration_property.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:share/share.dart';

class EventDetail extends StatefulWidget {
  final int position;
  final List<Events> eventsList;

  EventDetail(this.position, this.eventsList);

  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  AutoScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = AutoScrollController();

    scrollController.scrollToIndex(widget.position,
        duration: Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height - 200,
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(30.0)),
                ),
                child: Hero(
                  tag: widget.position,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0)),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/material.jpg'),
                            fit: BoxFit.cover,
                          )),
                      child: Container(
                        decoration: BoxDecoration(gradient: getImageGradient()),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Colors.black,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    FadeAnimation(
                      0.5,
                      Text(
                        widget.eventsList[widget.position].eventTitle,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
//                    Row(
//                      children: <Widget>[
//                        IconButton(
//                          icon: Icon(Icons.search),
//                          iconSize: 30.0,
//                          color: Colors.black,
//                          onPressed: () {},
//                        ),
//                        IconButton(
//                          icon: Icon(Icons.sort),
//                          iconSize: 30.0,
//                          color: Colors.black,
//                          onPressed: () {},
//                        ),
//                      ],
//                    )
                  ],
                ),
              ),
              Positioned(
                left: 15.0,
                top: 90.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(
                      0.5,
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.description,
                            size: 25.0,
                            color: Colors.white70,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width - 50,
                            child: Text(
                              widget
                                  .eventsList[widget.position].eventDescription,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 20.0,
                              ),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    FadeAnimation(
                      1,
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 25.0,
                            color: Colors.white70,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width - 50,
                            child: Text(
                              widget.eventsList[widget.position].eventBranch +
                                  " branch ",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    FadeAnimation(
                      1.5,
                      Row(
                        children: [
                          Icon(
                            Icons.sort,
                            size: 25.0,
                            color: Colors.white70,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width - 50,
                            child: Text(
                              widget.eventsList[widget.position].selectedLevel +
                                  " level cusromers and " +
                                  widget.eventsList[widget.position]
                                      .numberOfPeople
                                      .toString() +
                                  " people",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    FadeAnimation(
                      2,
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 25.0,
                            color: Colors.white70,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width - 50,
                            child: Text(
                              widget.eventsList[widget.position].eventDate
                                  .substring(1, 10) +
                                  " @ " +
                                  widget.eventsList[widget.position].eventStartTime,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    FadeAnimation(
                      2.5,
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            size: 25.0,
                            color: Colors.white70,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width - 50,
                            child: Text(
                              calculateLeftDays(widget
                                  .eventsList[widget.position].eventDate) +
                                  " days left ",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 5.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 22.0),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            FontAwesomeIcons.solidThumbsDown,
                            color: Colors.white70,
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 16.0,
                            ),
                            InkWell(
                              onTap: () {},
                              splashColor: Colors.red,
                              child: Icon(
                                FontAwesomeIcons.solidThumbsUp,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            InkWell(
                              onTap: () {
                                shareEvent(widget.eventsList[widget.position]);
                              },
                              child: Icon(
                                Icons.share,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(
                              width: 16.0,
                            )
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
          Expanded(
            child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                itemCount: widget.eventsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/EventDetail',
                          arguments:
                          EventScreenArgument(index, widget.eventsList));
                    },
                    child: AutoScrollTag(
                      key: ValueKey(index),
                      controller: scrollController,
                      index: index,
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                              height: 170.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Theme
                                      .of(context)
                                      .accentColor,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Padding(
                                padding:
                                EdgeInsets.fromLTRB(80.0, 20.0, 20.0, 20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                widget.eventsList[index]
                                                    .eventTitle,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 22.0,
                                                    color: Colors.white),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                              Text(
                                                widget.eventsList[index]
                                                    .eventBranch +
                                                    " Branch",
                                                style: TextStyle(
                                                    color: Colors.white70),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              widget
                                                  .eventsList[index].eventStartTime,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 22.0,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              'local time',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white70),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16.0,
                                    ),
                                    Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              widget.eventsList[index].eventDate
                                                  .substring(0, 10),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0),
                                            ),
                                            Text('tap for details')
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20.0,
                              top: 15.0,
                              bottom: 15.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image(
                                  width: 90.0,
                                  image: AssetImage('assets/images/image3.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Row buildRatingStars(int rating) {
    return Row(
      children: <Widget>[
        for (int i = 0; i < rating; i++)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2.0),
            child: Icon(
              Icons.star,
              size: 15.0,
              color: Colors.orange,
            ),
          )
      ],
    );
  }

  String calculateLeftDays(String eventDate) {
    return DateTime.parse(eventDate)
        .difference(new DateTime.now())
        .inDays
        .toString();
  }

  void shareEvent(Events event) {
    final RenderBox box = context.findRenderObject();
    Share.share(
        "There is an event goint to be held at ${event.eventBranch} - @ ${event.eventDate.substring(0, 10)},${event.eventStartTime} please join us.",
        subject:
            "It is available for ${event.numberOfPeople}. Here is the detail for the event ${event.eventDescription}",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
