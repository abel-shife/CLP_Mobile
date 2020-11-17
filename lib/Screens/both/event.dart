import 'dart:convert';

import 'package:async/async.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finalloyal/AppServices/Debouncer.dart';
import 'package:finalloyal/AppServices/NetworkHandler.dart';
import 'package:finalloyal/animations/FadeAnimation.dart';
import 'package:finalloyal/animations/Shimmers.dart';
import 'package:finalloyal/models/client_model.dart';
import 'package:finalloyal/models/events_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finalloyal/properties/box_decoration_property.dart';
import 'package:shimmer/shimmer.dart';

class Event extends StatefulWidget {

  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
  SharedPreferences preferences;

  AllEvents allEvents;
  List<Events> eventsList;
  List<Events> filteredEventsList;
  final AsyncMemoizer memoizer = AsyncMemoizer();
  final Debouncer debouncer = Debouncer(500);
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchEvents(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                networkErrorShimmerBuilder(),
                Row(
                  children: [
                    Icon(Icons.arrow_back_ios),
                    Text('Slide to refresh'),
                    Icon(Icons.arrow_forward_ios),
                  ],
                )
              ],
            );
            break;
          case ConnectionState.active:
            break;
          case ConnectionState.waiting:
            return Center(
              child: listShimmerBuilder(),
            );
            break;
          case ConnectionState.done:
            if (snapshot.hasError)
              return networkErrorShimmerBuilder();
            else
              return eventBuilder();
            break;
        }
        return null;
      },
    );
  }

  RefreshIndicator eventBuilder() {
    return RefreshIndicator(
      onRefresh: refreshEvents,
      child:  eventsList!=null? Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: getElevationProperty(),
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.search),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        autofocus: false,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 15, right: 15),
                            hintText: "Date or Name",
                            filled: false,
                            border: InputBorder.none),
                        onChanged: (value) {
                          debouncer.run(() {
                            setState(() {
                              filteredEventsList = eventsList
                                  .where((element) => (element.eventTitle
                                          .toLowerCase()
                                          .contains(value.toLowerCase()) ||
                                      element.eventDate
                                          .toLowerCase()
                                          .contains(value.toLowerCase())))
                                  .toList();
                            });
                          });
                        },
                      ),
                    ),
                    VerticalDivider(
                      thickness: 2.0,
                      color: Theme.of(context).primaryColor,
                      indent: 7.0,
                      endIndent: 7.0,
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            filteredEventsList.sort(
                                (a, b) => a.eventTitle.compareTo(b.eventTitle));
                          });
                          Fluttertoast.showToast(
                              msg: "Sorted By Name",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black26,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                        child: Icon(Icons.sort_by_alpha)),
                    SizedBox(
                      width: 20.0,
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            filteredEventsList.sort(
                                (a, b) => a.eventDate.compareTo(b.eventDate));
                          });
                          Fluttertoast.showToast(
                              msg: "Sorted By Date",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black26,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                        child: Icon(Icons.date_range)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Scrollbar(
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                  itemCount: filteredEventsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/EventDetail',
                            arguments:
                                EventScreenArgument(index, filteredEventsList));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                              height: 170.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
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
                                                filteredEventsList[index]
                                                    .eventTitle,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 22.0,
                                                    color: Colors.white),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                              Text(
                                                filteredEventsList[index]
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
                                              filteredEventsList[index]
                                                  .eventStartTime,
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
                                          filteredEventsList[index]
                                              .eventDate
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
                              child: Hero(
                                tag: index,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: CachedNetworkImage(
                                    width: 90.0,
                                    fit: BoxFit.fill,
                                    placeholder: (context, url) {
                                      return imagePlaceHolder();
                                    },
                                    imageUrl:
                                        'http://192.168.8.104/Users/biruk/Documents/VUE/CLP-master/client/src/assets/images/img-1597062484883.jpg',
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ): Center(
          child:Row(
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
                    Text('There are no ',style: TextStyle(fontSize: 18.0),),
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
                    Text('events available', style: TextStyle(fontSize: 18.0),),
                    Icon(Icons.arrow_forward_ios,size: 30.0,),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Future<void> fetchEvents() {
//    CheckConnection.isConnected().then((value) async {
//      if (value)
//      {

    return this.memoizer.runOnce(() async {
      var response = await NetworkHandler.get('getAllEvents');
      var decodedResponse = jsonDecode(response.body);
      allEvents = AllEvents.fromJson(decodedResponse);
      eventsList = allEvents.allEvents;
//    setState(() {

//      setState(() {
      filteredEventsList = eventsList;
    });

//      });

//        saveEvents();
//      }else if(!value){
//        loadEvents();
//      }
//    });
  }

  Future<void> refreshEvents() async {
//    CheckConnection.isConnected().then((value) async {
//      if (value)
//      {

    var response = await NetworkHandler.get('getAllEvents');
    var decodedResponse = jsonDecode(response.body);
    allEvents = AllEvents.fromJson(decodedResponse);
    eventsList = allEvents.allEvents;
//    setState(() {

//      setState(() {
    filteredEventsList = eventsList;
    searchController.clear();
    setState(() {});

//      });

//        saveEvents();
//      }else if(!value){
//        loadEvents();
//      }
//    });
  }

  saveEvents() async {
    preferences = await SharedPreferences.getInstance();
    if (preferences.getStringList('events') != null)
      preferences.remove('events');
    preferences.setStringList(
        'events',
        filteredEventsList
            .map((event) => jsonEncode(Events.toMap(event)))
            .toList());
  }

  loadEvents() async {
    preferences = await SharedPreferences.getInstance();

    List<String> tempEvent = preferences.getStringList('events');
    eventsList =
        tempEvent.map((item) => Events.fromJson(jsonDecode(item))).toList();
  }
}

class EventScreenArgument {
  final int index;
  final List<Events> eventsList;

  EventScreenArgument(this.index, this.eventsList);
}
